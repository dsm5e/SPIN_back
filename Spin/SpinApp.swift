//
//  SpinApp.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

@main

struct SpinApp: App {
    @StateObject var authenticationManager = AuthenticationManager()
    @Environment(\.scenePhase) private var scenePhase
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
        }
        
        .onChange(of: scenePhase) { phase in
            print("Состояние приложения: \(phase)")
            if case .background = phase, authenticationManager.isAuthenticated {
                showFaceID = true
            }
        }
    }
}
