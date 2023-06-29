//
//  PrettyJson.swift
//  Spin
//
//  Created by dsm 5e on 22.05.2023.
//

import Foundation

extension Data {
    /// Выводит красивый вид для `Data` в тексте
    var prettyJson: String {
        if let object = try? JSONSerialization.jsonObject(with: self, options: [.fragmentsAllowed]),
           let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
           let json = String(data: jsonData, encoding: .utf8) {
            return json
        } else {
            return ""
        }
    }
    
    /// Добавляем поля в `body`
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
