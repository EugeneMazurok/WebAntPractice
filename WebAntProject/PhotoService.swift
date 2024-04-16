//
//  PhotoService.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 16.04.2024.
//

import Foundation
import Alamofire

class PhotoService {

     func getPhotos(page: Int, isNew: Bool, isPopular: Bool, completion: @escaping ([PhotoFinalModel]?, Error?) -> Void) {
        AF.request("https://gallery.prod1.webant.ru/api/photos?page=\(page)&limit=10")
            .validate()
            .responseDecodable(of: PhotoResponse.self) { response in
                switch response.result {
                case .success(let photoResponse):

                    self.getMediaObjects(for: photoResponse.data) { mediaObjects, error in
                        if let error = error {
                            completion(nil, error)
                            return
                        }

                        self.combinePhotoData(photoResponse.data, with: mediaObjects) { photosFinal in
                            var filteredPhotos = photosFinal
                            if isNew {
                                filteredPhotos = filteredPhotos.filter { $0.new }
                            }
                            if isPopular {
                                filteredPhotos = filteredPhotos.filter { $0.popular }
                            }

                            completion(filteredPhotos, nil)
                        }
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    private func getMediaObjects(for photos: [Photo], completion: @escaping ([MediaObjectModel], Error?) -> Void) {
        var mediaObjects: [MediaObjectModel] = []
        let dispatchGroup = DispatchGroup()

        for photo in photos {
            dispatchGroup.enter()
            AF.request("https://gallery.prod1.webant.ru/api/media_objects/\(photo.image.id)")
                .validate()
                .responseDecodable(of: MediaObjectModel.self) { response in
                    switch response.result {
                    case .success(let mediaObject):
                        mediaObjects.append(mediaObject)
                    case .failure(let error):
                        print("Failed to load media object for photo with ID \(photo.id): \(error)")
                    }
                    dispatchGroup.leave()
                }
        }

        dispatchGroup.notify(queue: .main) {
            completion(mediaObjects, nil)
        }
    }

    func getUser(byId id: String, completion: @escaping (UserModel?, Error?) -> Void) {

        AF.request("https://gallery.prod1.webant.ru\(id)")
            .validate()
            .responseDecodable(of: UserModel.self) { response in
                switch response.result {
                case .success(let user):
                    completion(user, nil)
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                }
            }
    }

    private func combinePhotoData(_ photos: [Photo], with mediaObjects: [MediaObjectModel], completion: @escaping ([PhotoFinalModel]) -> Void) {
        var photosFinal: [PhotoFinalModel] = []

        let dispatchGroup = DispatchGroup() 

        for photo in photos {

            if let mediaObject = mediaObjects.first(where: { $0.id == photo.image.id }) {
                dispatchGroup.enter()

                getUser(byId: photo.user) { userModel, _ in
                    if let userModel = userModel {
                        let photoFinal = PhotoFinalModel(id: photo.id,
                                                         name: photo.name,
                                                         dateCreate: photo.dateCreate,
                                                         description: photo.description,
                                                         new: photo.new,
                                                         popular: photo.popular,
                                                         file: mediaObject.file,
                                                         fileName: mediaObject.name,
                                                         user: userModel)
                        photosFinal.append(photoFinal)
                    } else {
                        print("Failed to fetch user for photo with ID \(photo.id)")
                    }
                    dispatchGroup.leave()
                }

            } else {
                print("Media object not found for photo with ID \(photo.id)")
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("All requests completed")
            completion(photosFinal)
        }
    }
}
