//
//  SpinApiUrlSession.swift
//  Spin
//
//  Created by dsm 5e on 07.05.2023.
//

import Foundation

struct UploadImageResponse: Decodable {
    let id: String
    let name: String
    let url: String
}

struct ImageFile: Encodable {
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

enum ApiService {
    static let login = "igalkin@spin4spin.com"
    static let password = "12121212"
    static let encodedAuthString = (login + ":" + password).data(using: .utf8)?.base64EncodedString()
    static func uploadImages(_ imageModels: [ImageFile]) async throws {
        let boundary = UUID().uuidString
        let urlString = "https://cms.spin4spin.com/api/documents/upload-comitent-paper"
        guard let url = URL(string: urlString), let encodedAuthString else {
            throw SpinError.badURL
        }
        var request = URLRequest(url: url)
        let body = makeBodyWithMultipartForm(
            boundary: boundary,
            fieldsDictionary: [:], // сюда надо передать словарь из полей и значений для сервера, например айдишник и его значение
            with: imageModels
        )
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(encodedAuthString)", forHTTPHeaderField: "Authorization")
        request.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: request)
        dump(response)
        let decodedResponse = try JSONDecoder().decode(UploadImageResponse.self, from: data)
        print("получили название файла: \(decodedResponse.name)")
    }
    
    static func makeBodyWithMultipartForm(
        boundary: String,
        fieldsDictionary: [String: String],
        with images: [ImageFile]
    ) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        fieldsDictionary.forEach { key, value in
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value + lineBreak)")
        }
        images.forEach { image in
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(image.key)\"; filename=\"\(image.filename)\"\(lineBreak)")
            body.append("Content-Type: \(image.mimeType + lineBreak + lineBreak)")
            body.append(image.data)
            body.append(lineBreak)
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

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
