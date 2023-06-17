//
//  AuthUserModel.swift
//  Spin
//
//  Created by dsm 5e on 22.05.2023.
//

import Foundation

struct AuthUserModel: Decodable {
    let id, name, email, permissionClass: String?
    let createdAt, updatedAt: String?
    let token: String?
}
