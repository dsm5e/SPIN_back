//
//  LoginPageVIew.swift
//  Spin
//
//  Created by Golyakovph on 27.04.2023.
//

import SwiftUI

struct FaceIdView: View {
    
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            LoginTitle(title: "SPIN4SPIN", showSeconTitle: true)
            Spacer()
            switch authenticationManager.biometryType {
            case .faceID:
                PrimaryButton(title: "Вход с FaceID", image: "faceid", size: 40)
                    .onTapGesture {
                        Task.init {
                            await authenticationManager.authenticateWithBiometrics()
                            dismiss()
                        }
                    }
            case .touchID:
                PrimaryButton(title: "Вход с TouchID", image: "touchid", size: 40)
                    .onTapGesture {
                        Task.init {
                            await authenticationManager.authenticateWithBiometrics()
                        }
                    }
            default:
                NavigationLink {
                    LoginCredentialsView()
                        .environmentObject(authenticationManager)
                } label: {
                    PrimaryButton(title: "Вход с учетными данными", image: "person.fill", size: 10)
                    
                }
            }
            
            Spacer()
        } .padding(.top, 100)
    }
}

struct LoginPageVIew_Previews: PreviewProvider {
    static var previews: some View {
        FaceIdView()
            .environmentObject(AuthenticationManager())
    }
}

