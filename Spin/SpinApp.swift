//
//  SpinApp.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

@main

struct SpinApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var authenticationManager = AuthenticationManager()
    @StateObject var networkService = ApiService()
    @State private var showFaceID = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if authenticationManager.isAuthenticated {
                    RootView()
                } else {
                    LoginCredentialsView()
                        .environmentObject(authenticationManager)
                }
            }
            .fullScreenCover(isPresented: $showFaceID) {
                FaceIdView()
                    .environmentObject(authenticationManager)
            }
            .environmentObject(networkService)
        }
        
        .onChange(of: scenePhase) { phase in
            print("Состояние приложения: \(phase)")
            if case .background = phase, authenticationManager.isAuthenticated {
                showFaceID = true
            }
        }
    }
}
