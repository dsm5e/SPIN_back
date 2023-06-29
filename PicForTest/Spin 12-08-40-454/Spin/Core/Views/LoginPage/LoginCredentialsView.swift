//
//  LoginCredentialsView.swift
//  Spin
//
//  Created by Golyakovph on 27.04.2023.
//

import SwiftUI

enum FocusedField {
    case username, password
}

struct LoginCredentialsView: View {
    
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @FocusState private var focusedField: FocusedField?
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 0) {
            LoginTitle(title: "SPIN4SPIN", showSeconTitle: true)
                .padding(.bottom, 50)
            usernameTF
            secureTF
            Spacer()
            
            PrimaryButton(title: "Вход", showImage: false, size: 200)
                .padding(.bottom, 15)
                .onTapGesture {
                    Task {
                        await authenticationManager.serverAuthenticate(mail: username, password: password)
                    }
                }
                .frame(maxWidth: .infinity)
            Text("Забыл пароль?")
                .font(.callout)
            Spacer()
        }
        .applyLoadingModifier(isLoading: authenticationManager.isLoading)
        .padding(.top, 100)
        .alert(isPresented: $authenticationManager.showErrorAlert) {
            Alert(title: Text("Неверный логин или пароль"), message: Text(authenticationManager.errorDescription ?? "Попробуйте еще раз"), dismissButton: .default(Text("ОК")))
        }
        .onTapGesture {
            focusedField = nil
        }
    }
    
    var usernameTF: some View {
        TextField("", text: $username)
            .focused($focusedField, equals: .username)
            .padding()
            .foregroundColor(Color.black.opacity(0.8))
            .placeholder(when: username.isEmpty, placeholder: {
                Text("Введите почту").foregroundColor(.gray)
                    .padding(.horizontal)
            })
            .background(Color.textfieldColor)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.borderColor, lineWidth: 1))
            .cornerRadius(15)
            .padding()
    }
    
    var secureTF: some View {
        SecureField("", text: $password)
            .focused($focusedField, equals: .password)
            .padding()
            .foregroundColor(Color.black.opacity(0.8))
            .placeholder(when: password.isEmpty, placeholder: {
                Text("Введите пароль").foregroundColor(.gray)
                    .padding(.horizontal)
            })
            .background(Color.textfieldColor)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.borderColor, lineWidth: 1))
            .cornerRadius(15)
            .padding(.horizontal)
    }
}


struct LoginCredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginCredentialsView()
            .environmentObject(AuthenticationManager())
    }
}
