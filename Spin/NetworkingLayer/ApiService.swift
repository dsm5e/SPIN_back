//
//  PriemkiVM.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import Foundation
import UIKit
import Alamofire

final class ApiService: ObservableObject {
    @Published var acceptances: [AcceptanceModel] = []
    @Published var acceptanceItems: [ItemModel1C] = []
    @Published var item1C: ItemModel1C?
    @Published var brands: [Brand] = [] // hint - наименование
    @Published var categories: [Brand] = [] // hint - наименование
    /// Бренд, выбранный на этапе редактирования карточки
    @Published private(set) var selectedBrand: Brand?
    /// Категория, выбранная на этапе редактирования карточки
    @Published private(set) var selectedCategory: Brand?
    
    func selectBrand(_ brand: Brand) {
        selectedBrand = brand
    }
    
    func selectCategory(_ category: Brand) {
        selectedCategory = category
    }
    
    func formatDate() -> String {
        guard let dateString = item1C?.createdAt else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let lastDate = formatter1.string(from: date)
        print(formatter1.string(from: date))
        return lastDate
    }
    
    @MainActor
    func fetchAcceptances() async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/acceptances/list") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let resultDecoded = try JSONDecoder().decode([AcceptanceModel].self, from: data)
            acceptances = resultDecoded
            print(acceptances)
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchAcceptanceItems(id: String) async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/acceptances/get-items?id=\(id)") else { return }
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let resultDecoded = try JSONDecoder().decode([ItemModel1C].self, from: data)
            print(resultDecoded)
            acceptanceItems = resultDecoded
            print(acceptanceItems.count)
        } catch {
            print(error)
        }
    }
    
    
    @MainActor
    func get1cItem(id: String) async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/items/\(id)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let resultDecoded = try JSONDecoder().decode(ItemModel1C.self, from: data)
            await MainActor.run { item1C = resultDecoded }
            print(resultDecoded)
        } catch {
            print(error)
        }
    }
    
    func saveImage(image: UIImage?) -> UIImage? {
        guard let image = image else {
            print("Нет изображения")
            return nil
        }
        // Сохранение изображения
        return image
    }
    
    
    func update1cItem(id: String, item: ItemModel1C) async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/items/update?id=\(id)"),
              let selectedBrand, let selectedCategory
        else { return }
        let finalItem = ItemModel1C(
            id: item.id,
            id1C: item.id1C,
            name: item.name,
            categories: [selectedCategory],
            brands: [selectedBrand],
            style: item.style,
            size: item.size,
            condition: item.condition,
            prices: item.prices,
            images: item.images,
            descriptions: item.descriptions,
            createdAt: item.createdAt,
            updatedAt: item.updatedAt,
            acceptance: item.acceptance,
            staffPhoto: item.staffPhoto,
            status: item.status
        )
        do {
            let bodyData = try JSONEncoder().encode(finalItem)
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = bodyData
            let (data, _) = try await URLSession.shared.data(for: request)
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            let resultDecoded = try JSONDecoder().decode(ItemModel1C.self, from: data)
            await MainActor.run { item1C = resultDecoded }
        } catch {
            dump(error)
        }
    }
    
    func getBrands() async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/brands/list") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let resultDecoded = try JSONDecoder().decode([Brand].self, from: data)
            await MainActor.run { brands = resultDecoded }
        } catch {
            print(error)
        }
    }
    
    func getCategories() async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/categories/list") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let resultDecoded = try JSONDecoder().decode([Brand].self, from: data)
            await MainActor.run { categories = resultDecoded }
        } catch {
            print(error)
        }
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

enum ImageService {
    static func uploadComitentPhoto(_ imageModels: [ImageFile]) async throws {
        let boundary = UUID().uuidString
        let urlString = "https://cms.spin4spin.com/api/documents/upload-comitent-paper"
        guard let url = URL(string: urlString) else {
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
        request.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: request)
        dump(response)
        let decodedResponse = try JSONDecoder().decode(UploadImageResponse.self, from: data)
        print("получили название файла: \(decodedResponse.name)")
    }
    
    static func uploadNewItemsPhoto(_ imageModel: ImageFile, id: String) async throws {
        let boundary = UUID().uuidString
        let urlString = "https://cms.spin4spin.com/api/items/add-image?id=\(id)"
        guard let url = URL(string: urlString) else {
            print("неправильный url")
            throw SpinError.badURL
        }
        var request = URLRequest(url: url)
        let body = makeBodyWithMultipartFormForNewItems(boundary: boundary, with: imageModel)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        print(body.prettyJson)
        let (data, _) = try await URLSession.shared.data(for: request)
        print(data.description.utf8)
        print(data.prettyJson)
        print(data.prettyPrintedJSONString)
        let decodedResponse = try JSONDecoder().decode(UploadImageResponse.self, from: data)
        print("получили название файла: \(decodedResponse.name)")
    }
    
    static func makeBodyWithMultipartFormForNewItems(
        boundary: String,
        with image: ImageFile
    ) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        body.append("--\(boundary + lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(image.key)\"; filename=\"\(image.filename)\"\(lineBreak)")
        body.append("Content-Type: \(image.mimeType + lineBreak + lineBreak)")
        body.append(image.data)
        body.append(lineBreak)
        body.append("--\(boundary)--\(lineBreak)")
        return body
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
