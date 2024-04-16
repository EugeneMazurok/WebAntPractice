//
//  PhotoResponseModel.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 16.04.2024.
//

import Foundation

struct PhotoResponse: Decodable {
    let totalItems: Int
    let itemsPerPage: Int
    let countOfPages: Int
    let data: [Photo]
}
