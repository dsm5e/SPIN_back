//
//  PriemkiVM.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import Foundation

final class PriemkiVM: ObservableObject {
    @Published var lists: [PriemkiModel] = []
    @Published var item1C: ItemModel1C?

    @MainActor
    func getPosts() async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/acceptances/list"),
              let encodedAuthString = ApiService.encodedAuthString else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(encodedAuthString)", forHTTPHeaderField: "Authorization")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let resultDecoded = try JSONDecoder().decode([PriemkiModel].self, from: data)
            print(data.prettyJson)
            lists = resultDecoded
        } catch {
            print(error)
        }
    }
    
    func get1cItem(id: String) {
        guard let url = URL(string: "https://cms.spin4spin.com/api/items/\(id)"),
              let encodedAuthString = ApiService.encodedAuthString else { return }
        Task {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(encodedAuthString)", forHTTPHeaderField: "Authorization")
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let resultDecoded = try JSONDecoder().decode(ItemModel1C.self, from: data)
                print(data.prettyJson)
                await MainActor.run { item1C = resultDecoded }
            } catch {
                print(error)
            }
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
