//
//  TabOneViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

import Alamofire

class TabOneViewController: UIViewController {
    private var photoGridViewController: PhotoGridViewController!
    private var collectionViewLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New"
        view.backgroundColor = .blue

        let photoGridViewController = PhotoGridViewController(photos: [], collectionViewLayout: UICollectionViewFlowLayout(), photoType: .new)
        let navigationController = UINavigationController(rootViewController: photoGridViewController)
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        navigationController.view.frame = view.bounds
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
