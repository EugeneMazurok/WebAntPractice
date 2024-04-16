//
//  PhotoGridView.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class PhotoGridViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var photos: [Photo] = []

    init(photos: [Photo], collectionViewLayout layout: UICollectionViewLayout) {
        self.photos = photos
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PhotoGridCell.self, forCellWithReuseIdentifier: PhotoGridCell.reuseIdentifier)
        collectionView.backgroundColor = .white

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView.collectionViewLayout.invalidateLayout()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.reuseIdentifier, for: indexPath) as? PhotoGridCell else {
            fatalError("Unable to dequeue PhotoGridCell")
        }

        let photo = photos[indexPath.item] // Предположим, что у вас есть массив photos с объектами типа Photo

        cell.configure(withPhoto: photo)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 2 // Делим экран на две колонки
        return CGSize(width: width, height: width)
    }
}
