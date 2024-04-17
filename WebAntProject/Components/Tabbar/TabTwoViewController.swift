//
//  TabTwoViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class TabTwoViewController: UIViewController {
    private var photoGridViewController: PhotoGridViewController!
    private var collectionViewLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular"
        view.backgroundColor = .blue

        let photoGridViewController = PhotoGridViewController(photos: [], collectionViewLayout: UICollectionViewFlowLayout(), photoType:.popular)
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
