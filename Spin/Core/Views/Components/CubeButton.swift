//
//  CubeButton.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import SwiftUI

struct CubeButton: View {
    var title: String
    var timeTitle: String
    var count: Int?
    
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .cornerRadius(15)
            .shadow(color: .accentColor.opacity(0.5), radius: 5, y: 5)
            .overlay {
                VStack {
                    Text("\(title)")
                        .font(.system(size: 12))
                        .bold()
                        .padding(.top, 5)
                    Text("\(timeTitle)")
                        .font(.caption)
                        .padding(.bottom, 0.1)
                    Text("\(count ?? 0)")
                        .font(.headline)
                }
                .foregroundColor(.firstTtext)
            }
    }
}

struct CubeButton_Previews: PreviewProvider {
    static var previews: some View {
        CubeButton(title: "ПEРЕОЦЕНКИ", timeTitle: "за месяц")
    }
}
