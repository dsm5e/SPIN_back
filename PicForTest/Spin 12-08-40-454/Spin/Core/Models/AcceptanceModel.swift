//
//  PriemkiModel.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import Foundation

struct AcceptanceModel: Identifiable, Codable {
    var id, id1C, comitentID, date: String
    var numberOfItems: Int
    var updateLog: [UpdateLog]

    enum CodingKeys: String, CodingKey {
        case id
        case id1C = "id1c"
        case comitentID = "comitentId"
        case date, numberOfItems, updateLog
    }
}

// MARK: - UpdateLog
struct UpdateLog: Codable {
    var timestamp, user, type: String
    var updatedFields: [UpdatedField]
}

// MARK: - UpdatedField
struct UpdatedField: Codable {
    var key, from, to: String
}
