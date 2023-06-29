//
//  ToolsView.swift
//  Spin
//
//  Created by Golyakovph on 26.04.2023.
//

import SwiftUI

struct ToolsView: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            NavigationLink {
                ScanerView()
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.accentColor)
                        .cornerRadius(20)
                    Text("Штрихкодер")
                        .font(.title3)
                        .foregroundColor(.firstTtext)
                }
            }
            Spacer()
            NavigationLink {
                DocView()
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.accentColor)
                        .cornerRadius(20)
                    Text("Документы")
                        .font(.title3)
                        .foregroundColor(.firstTtext)
                }
            }
            Spacer()
            
        }
        .padding()
        .padding(.top, 30)
        .navigationTitle("Фичи")
        
        Spacer()
    }
}

extension ToolsView {
    struct AlertItem: Identifiable {
        let id            = UUID()
        let title         : Text
        let message       : Text
        let dismissButton : Alert.Button
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ToolsView()
        }
    }
}
