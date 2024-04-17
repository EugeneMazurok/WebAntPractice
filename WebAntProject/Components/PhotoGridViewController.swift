//
//  PhotoGridView.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class PhotoGridViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var photos: [PhotoFinalModel] = []
    private var currentPage: Int = 1
    private var isFetching: Bool = false
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let numberOfItemsPerRow: Int = 2
    var photoType: PhotoType

    init(photos: [PhotoFinalModel], collectionViewLayout layout: UICollectionViewLayout, photoType: PhotoType) {
        self.photos = photos
        self.photoType = photoType
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func refreshData() {
        // Reset current page to 1
        self.currentPage = 1
        // Clear previous data
        photos.removeAll()
        collectionView.reloadData()
        // Fetch new data
        fetchPhotos(page: self.currentPage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PhotoGridCell.self, forCellWithReuseIdentifier: PhotoGridCell.reuseIdentifier)
        collectionView.backgroundColor = .white

        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            collectionView.refreshControl = refreshControl
        collectionView.addSubview(activityIndicator)
        activityIndicator.color = .black
        activityIndicator.center = collectionView.center // Центрируем индикатор загрузки
        activityIndicator.isHidden = true

        fetchPhotos(page: currentPage)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.reuseIdentifier, for: indexPath) as? PhotoGridCell else {
            fatalError("Unable to dequeue PhotoGridCell")
        }

        let photo = self.photos[indexPath.item]
        cell.configure(withPhoto: photo)

        // Fetch more photos when reaching the last item
        if indexPath.item == photos.count - 1 && !isFetching {
            currentPage += 1
            fetchPhotos(page: currentPage)
        }

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = self.photos[indexPath.item]
        let detailVC = PhotoDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.photo = photo
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && !isFetching {
            currentPage += 1
            fetchPhotos(page: currentPage)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(numberOfItemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(numberOfItemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    private func fetchPhotos(page: Int) {
        guard !isFetching else { return }
        isFetching = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let showRefreshControl = (page == 1)
            if showRefreshControl {
                collectionView.refreshControl?.beginRefreshing()
            }

        PhotoService().getPhotos(page: page, isNew: self.photoType == .new, isPopular: self.photoType == .popular) { [weak self] photos, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching photos: \(error)")
                return
            }

            if let photos = photos {
                self.isFetching = false
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                let previousItemCount = self.photos.count
                self.photos.append(contentsOf: photos)
                let indexPaths = (previousItemCount..<self.photos.count).map { IndexPath(item: $0, section: 0) }
                self.collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: indexPaths)
                }, completion: { _ in
                    // Scroll to the first newly added item
                    if previousItemCount == 0 && !self.photos.isEmpty {
                        self.collectionView.scrollToItem(at: indexPaths[0], at: .top, animated: true)
                    }
                    // Update indicator position
                    self.collectionView.refreshControl?.endRefreshing()
                    self.updateActivityIndicatorPosition()

                })
            } else {
                print("No photos received")
            }
        }
    }

    private func updateActivityIndicatorPosition() {
        // Calculate the content height including the newly added items
        let contentHeight = collectionView.contentSize.height + activityIndicator.bounds.height
        // Update the position of the activity indicator
        activityIndicator.frame = CGRect(x: 0, y: contentHeight, width: collectionView.bounds.width, height: activityIndicator.bounds.height)
    }
}
