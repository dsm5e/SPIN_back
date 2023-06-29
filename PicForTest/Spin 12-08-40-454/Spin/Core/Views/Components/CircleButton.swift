//
//  CircleButton.swift
//  Spin
//
//  Created by Golyakovph on 29.04.2023.
//

import SwiftUI

struct CircleButton: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(.accent)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .foregroundColor(.background)
            )
            .shadow(color: .accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(iconName: "gear")
            .previewLayout(.sizeThatFits)
    }
}
