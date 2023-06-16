//
//  AuthenticationManager.swift
//  Spin
//
//  Created by Golyakovph on 27.04.2023.
//

import Foundation
import LocalAuthentication
import SwiftUI
import Combine

struct ServerMessage: Decodable {
    let id, name, email, permissionClass: String?
    let createdAt, updatedAt: String?
    let token: String?
}


final class AuthenticationManager: ObservableObject {
    @AppStorage("isLoggedIn") private(set) var isAuthenticated = false
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    private(set) var canEvaluatePolicy = false
    @Published private(set) var errorDescription: String?
    @Published var showErrorAlert = false
    
    init() {
        getBiometryType()
    }
    
    func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        context = LAContext()
        
        if canEvaluatePolicy {
            let reason = "Вход в личную учетную запись"
            
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showErrorAlert = true
                    self.biometryType = .none
                }
            }
        }
    }
    
    func logOut() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}

extension AuthenticationManager {
    @MainActor
    func serverAuthenticate(mail: String, password: String) async {
        guard let url = URL(string: "https://cms.spin4spin.com/api/auth/login") else { return }
        
        let body: [String: String] = ["email": mail, "password": password]
        
        do {
            let finalBody = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            let resData = try JSONDecoder().decode(ServerMessage.self, from: data)
            if resData.email == mail {
                print("\(resData.name ?? "non name")" , "\(resData.email ?? "no email")" )
                isAuthenticated = true
            } else {
                showErrorAlert = true
            }
        } catch {
            showErrorAlert = true
        }
    }
}

