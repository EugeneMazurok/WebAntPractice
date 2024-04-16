//
//  PhotoCollectionViewCell.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class PhotoGridCell: UICollectionViewCell {

    static let reuseIdentifier = "PhotoGridCell"

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Добавляем photoImageView к ячейке
        contentView.addSubview(photoImageView)
        // Устанавливаем constraints для photoImageView
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withPhoto photo: Photo) {
        // Установите серый цвет для photoImageView
        photoImageView.backgroundColor = .lightGray
    }

}
