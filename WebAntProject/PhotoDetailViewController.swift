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

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(false, animated: true)
            tabBarController?.tabBar.isHidden = true
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white

        // Создаем UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Добавляем фото
        if let photo = photo, !photo.file.isEmpty {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            if let image = photo.file.convertToImage() {
                imageView.image = image
                scrollView.addSubview(imageView)
                imageView.translatesAutoresizingMaskIntoConstraints = false

                // Ограничиваем высоту изображения
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                    imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                    imageView.heightAnchor.constraint(equalToConstant: 300) // Примерная высота изображения
                ])
            }
        }

        // Название картинки
        let titleLabel = UILabel()
        titleLabel.text = photo?.name ?? ""
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        scrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 320) // Позиция под изображением
        ])

        // Информация о пользователе и дате
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10 // Устанавливаем расстояние между элементами в stackView

        // Создаем UILabel для имени пользователя
        let usernameLabel = UILabel()
        usernameLabel.text = photo?.user.username
        usernameLabel.textColor = .black
        usernameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal) // Устанавливаем высокий приоритет ужатия для имени пользователя

        // Создаем UILabel для даты создания

        let dateCreateLabel = UILabel()
        dateCreateLabel.text = photo?.dateCreate
        dateCreateLabel.textColor = .gray

        // Добавляем UILabel в stackView
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(dateCreateLabel)

        // Добавляем stackView в scrollView
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20), // Выравниваем stackView по левому краю
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20), // Выравниваем stackView по правому краю
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10) // Располагаем stackView под titleLabel
        ])
        // Описание картинки
        let descriptionLabel = UILabel()
        descriptionLabel.text = photo?.description ?? ""
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0 // Разрешаем несколько строк
        descriptionLabel.textColor = .black
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    }

extension String {
    func convertToImage() -> UIImage? {
        guard let base64String = self.components(separatedBy: ",").last,
              let data = Data(base64Encoded: base64String) else {
            return nil
        }
        return UIImage(data: data)
    }
}
