//
//  PrimaryButton.swift
//  Spin
//
//  Created by Golyakovph on 27.04.2023.
//

import SwiftUI

struct PrimaryButton: View {
    
    var title: String
    var image: String?
    var showImage = true
    var size: Int?
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
                .foregroundColor(.firstTtext)
            

            if showImage {
                Image(systemName: image ?? "person.fill")
                    .resizable()
                    .scaledToFit()
                    .colorMultiply(.firstTtext)
                    .frame(width: CGFloat(size ?? 100), height: 20)

            }
        }
        .padding()
//        .padding(.horizontal, CGFloat(size ?? 100))
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(15)
        .shadow(color: .accentColor.opacity(0.5), radius: 5, y: 5)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Вход с FaceID", image: "faceid", size: 40)
    }
}
