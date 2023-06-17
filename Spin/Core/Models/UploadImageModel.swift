//
//  UploadImageModel.swift
//  Spin
//
//  Created by dsm 5e on 22.05.2023.
//

import Foundation
import UIKit

struct UploadImageResponse: Decodable {
    let id: String
    let name: String
    let url: String
}

struct ImageFile: Encodable, Decodable {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init(imageData: Data, forKey key: String) {
        self.key = "photo\(key)"
        self.mimeType = "image/jpeg"
        self.filename = "photo\(key).jpg"
        self.data = imageData
    }
}

enum SpinError: Error {
    case badURL
}
