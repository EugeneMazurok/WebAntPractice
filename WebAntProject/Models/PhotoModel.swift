//
//  PhotoModel.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let name: String
    let dateCreate: String
    let description: String
    let new: Bool
    let popular: Bool
    let image: ImageModel
    let user: String
}
