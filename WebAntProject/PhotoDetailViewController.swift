//
//  PhotoDetailViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 16.04.2024.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    var photo: PhotoFinalModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let photo = photo else { return }

        // Название картинки
        let titleLabel = UILabel()
        titleLabel.text = photo.name
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Информация о пользователе и дате
        let userInfoLabel = UILabel()
        userInfoLabel.text = "\(photo.user.username) • \(photo.dateCreate)"
        userInfoLabel.font = UIFont.systemFont(ofSize: 14)
        userInfoLabel.textColor = .gray
        view.addSubview(userInfoLabel)
        userInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            userInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Описание картинки
        let descriptionLabel = UILabel()
                descriptionLabel.text = photo.description
                descriptionLabel.font = UIFont.systemFont(ofSize: 16)
                descriptionLabel.numberOfLines = 0 // Разрешаем несколько строк
        descriptionLabel.textColor = .black
                view.addSubview(descriptionLabel)
                descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    descriptionLabel.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 20),
                    descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
                ])
    }
}
