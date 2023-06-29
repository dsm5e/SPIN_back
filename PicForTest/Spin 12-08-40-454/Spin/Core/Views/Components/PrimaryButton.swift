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
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(15)
        .shadow(color: .accentColor.opacity(0.2), radius: 2, y: 3)
        .padding(.horizontal)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Вход с FaceID", image: "faceid", size: 40)
    }
}
