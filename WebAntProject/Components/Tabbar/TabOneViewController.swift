//
//  TabOneViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class TabOneViewController: UIViewController {

    override func viewDidLoad() {
         super.viewDidLoad()
         self.title = "New"

         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical

         let photos: [Photo] = [Photo(id: 0, name: "sd", dataCreate: "Date.now",
                                       description: "sd", new: true, popular: true,
                                       image: MediaObjectModel(file: "sd", name: "sd", id: 0), user: "sd"),
                                Photo(id: 0, name: "sd", dataCreate: "Date.now",
                                       description: "sd", new: true, popular: true,
                                       image: MediaObjectModel(file: "sd", name: "sd", id: 0), user: "sd"),
                                Photo(id: 0, name: "sd", dataCreate: "Date.now",
                                       description: "sd", new: true, popular: true,
                                       image: MediaObjectModel(file: "sd", name: "sd", id: 0), user: "sd")]
         let galleryCollectionViewController = PhotoGridViewController(photos: photos, collectionViewLayout: layout)
         galleryCollectionViewController.photos = photos // Передайте фотографии в коллекцию

         addChild(galleryCollectionViewController)
         view.addSubview(galleryCollectionViewController.view)

         galleryCollectionViewController.view.frame = view.bounds

         galleryCollectionViewController.didMove(toParent: self)
     }
}
