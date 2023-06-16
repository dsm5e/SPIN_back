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
    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        VStack(spacing: 0) {
            
            LoginTitle(title: "SPIN4SPIN", showSeconTitle: true)
                .padding(.bottom, 50)
            usernameTF
            secureTF
            
            Spacer()
            
            PrimaryButton(title: "Вход", showImage: false, size: 130)
                .padding(.bottom, 15)
                .onTapGesture {
                    Task.init {
                        await authenticationManager.serverAuthenticate(mail: username, password: password)
                    }
                }
            Text("Забыл пароль?")
                .font(.callout)
            
            Spacer()
        }
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
            .background(Color(red: 246/255, green: 246/255, blue: 246/255))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(red: 189/255, green: 189/255, blue: 189/255), lineWidth: 1))
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
            .background(Color(red: 246/255, green: 246/255, blue: 246/255))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(red: 189/255, green: 189/255, blue: 189/255), lineWidth: 1))
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
