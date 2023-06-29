//
//  AuthenticationManager.swift
//  Spin
//
//  Created by Golyakovph on 27.04.2023.
//

import Foundation
import LocalAuthentication
import SwiftUI

final class AuthenticationManager: ObservableObject {
    @AppStorage("isLoggedIn") private(set) var isAuthenticated = false
    private(set) var context = LAContext()
    private(set) var canEvaluatePolicy = false
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var errorDescription: String?
    @Published private(set) var isLoading = false
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
        isLoading = true
        
        let body: [String: String] = ["email": mail, "password": password]
        
        do {
            let finalBody = try JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            print(data.prettyJson)
            let resData = try JSONDecoder().decode(AuthUserModel.self, from: data)
            if resData.email == mail {
                isAuthenticated = true
            } else {
                showErrorAlert = true
            }
        } catch {
            showErrorAlert = true
        }
        isLoading = false
    }
}

