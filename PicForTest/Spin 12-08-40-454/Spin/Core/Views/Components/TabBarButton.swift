//
//  TabBarButton.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct TabBarButton: View {
    
    var buttonText: String
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        
        GeometryReader { geo in
            if isActive {
                Rectangle()
                    .foregroundColor(.accentColor)
                    .frame(width: geo.size.width/1.5, height: 2.5)
                    .cornerRadius(3)
                    .padding(.leading, geo.size.width/6)
            }
            
            VStack(alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(buttonText)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }.foregroundColor(.accent)
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Chats", imageName: "heart.fill", isActive: true)
    }
}
