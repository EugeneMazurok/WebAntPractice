//
//  UserModel.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 16.04.2024.
//

import Foundation

struct UserModel: Decodable {
    let id: Int
    let email: String
    let enabled: Bool
    let phone: String?
    let fullName: String?
    let username: String
    let birthday: String?
    let roles: [String]
}
