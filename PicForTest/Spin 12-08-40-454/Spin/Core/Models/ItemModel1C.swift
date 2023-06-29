// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let the1CItemModel = try? JSONDecoder().decode(The1CItemModel.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - The1CItemModel
struct ItemModel1C: Identifiable, Codable, Equatable {
    // все свойства, которые нужно менять, должны быть var
    let id, id1C: String
    var name: String
    var categories, brands: [Brand]
    var style, size, condition: String
    var prices: [Price]
    let images: [ImageItem1C]
    let descriptions: [Description]
    var createdAt, updatedAt: String
    var acceptance: String
    var staffPhoto: String
    var status: String
    

    enum CodingKeys: String, CodingKey {
        case id
        case id1C = "id1c"
        case name
        case categories = "category"
        case brands = "brand"
        case style, size, condition, prices, images, descriptions, createdAt, updatedAt, acceptance, status, staffPhoto
    }
}

// MARK: - Brand
struct Brand: Identifiable, Codable, Equatable  {
    let id: String
    var name: String
}

// MARK: - Description
struct Description: Codable, Equatable {
    let lang, content: String
}

// MARK: - Image
struct ImageItem1C: Codable, Equatable {
    let id, name, url: String
    let index: Int
}

// MARK: - Price
struct Price: Codable, Equatable {
    let name: String
    var value: Int
    let currency: String
}

// MARK: - UpdateLog
struct Item1C: Codable, Equatable {
    let timestamp, user, type: String
//    let updatedFields: [UpdateItemFields1C]? // должен быть один формат ответа, а не набор разных (если словарь, то словарь, если массив, то массив)
}

// MARK: - UpdatedField
struct UpdateItemFields1C: Codable, Equatable {
    let key, from, to: String?
}
