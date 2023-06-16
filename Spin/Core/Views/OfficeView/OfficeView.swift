//
//  OfficeView.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct OfficeView: View {
    @ObservedObject var authenticationManager = AuthenticationManager()
    @ObservedObject var vm = PriemkiVM()
    @State private var showSettings: Bool = false
    @State private var title: String = "SPIN4SPIN"
    
    var body: some View {
        VStack {
            officeHeader
            HStack(spacing: 15) {
                NavigationLink {
                    PriemkiView()
                } label: {
                    CubeButton(title: "ПРИЕМКИ", timeTitle: "за месяц", count: vm.lists.count)
                }
                Button {
                    
                } label: {
                    CubeButton(title: "ПЕРЕОЦЕНКИ", timeTitle: "в очереди")
                }
                Button {
                    
                } label: {
                    CubeButton(title: "ВОЗВРАТЫ", timeTitle: "в очереди")
                }
            }
            .padding(.top, 30)
            
            Spacer()
            if showSettings {
                settingsView
            }
        }
    }
    
}

struct OfficeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OfficeView()
        }
    }
}

extension OfficeView {
    var officeHeader: some View {
        HStack {
            CircleButton(iconName: "gear")
                .rotationEffect(.degrees(showSettings ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        showSettings.toggle()
                        title = showSettings ? "Настройки" : "SPIN4SPIN"
                    }
                }
            
            HeaderView(title: title, showSecondTitle: !showSettings)
            
            CircleButton(iconName: "person")
                .opacity(showSettings ? 0 : 1.0)
        }
    }
    
    var settingsView: some View {
        PrimaryButton(title: "Выход", image: "person", showImage: true, size: 20)
            .padding(.bottom, 30)
            .onTapGesture {
                authenticationManager.logOut()
                print(authenticationManager.isAuthenticated)
            }
    }
}
