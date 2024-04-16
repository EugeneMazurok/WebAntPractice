//
//  TabOneViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

import Alamofire

class TabOneViewController: UIViewController {
    private var photos: [PhotoFinalModel] = []
    private let photoService = PhotoService()
    override func viewDidLoad() {
             super.viewDidLoad()
             self.title = "New"
        navigationController?.isNavigationBarHidden = true
            let layout = UICollectionViewFlowLayout()
            self.photoService.getPhotos(page: 1, isNew: true, isPopular: false ) { photos, error in
                if let error = error {
                    print("Error fetching photos: \(error)")
                    return
                }

                if let photos = photos {
                    self.photos = photos
                    print(self.photos)
                    self.addPhotoGridViewController(withLayout: layout)
                } else {
                    print("No photos received")
                }
            }
        }

        private func addPhotoGridViewController(withLayout layout: UICollectionViewFlowLayout) {
            let galleryCollectionViewController = PhotoGridViewController(photos: self.photos, collectionViewLayout: layout)

            let navigationController = UINavigationController(rootViewController: galleryCollectionViewController)
            addChild(navigationController)
            view.addSubview(navigationController.view)
            navigationController.view.frame = view.bounds
            navigationController.didMove(toParent: self)
        }

}
