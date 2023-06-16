//
//  LoginTitle.swift
//  Spin
//
//  Created by Golyakovph on 27.04.2023.
//

import SwiftUI

struct LoginTitle: View {
    
    var title: String
    var showSeconTitle: Bool = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.accent)
            if showSeconTitle {
                Text("OFFICE")
                    .font(.callout)
                    .foregroundColor(.secondaryText)
            }
        }
    }
}

struct LoginTitle_Previews: PreviewProvider {
    static var previews: some View {
        LoginTitle(title: "Spin4spin")
    }
}
