//
//  PriemkiModel.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import Foundation

struct PriemkiModel: Identifiable, Codable {
    let id: String
    let id1c: String
    let comitentId: String
    let date: String
    let numberOfItems: Int
    let updateLog: [UpdateLog]
}

struct UpdateLog: Codable {
    let timestamp: String
    let user: String
    let type: String
    let updatedFields: [UpdatedFields]
}

struct UpdatedFields: Codable {
    let key: String
    let from: String
    let to: String
}
