//
//  ClientModel.swift
//  Spin
//
//  Created by dsm 5e on 06.05.2023.
//
import Foundation

struct ClientModel: Identifiable {
    let id = UUID().uuidString
    var name: String
    var secondName: String
    var number: String
    var documentLoad: Bool
    var doucmentCount: Int
}
