//
//  HeaderView.swift
//  Spin
//
//  Created by Golyakovph on 29.04.2023.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let showSecondTitle: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            LoginTitle(title: title, showSeconTitle: showSecondTitle)
        }
        .padding(.horizontal)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Spin", showSecondTitle: true)
    }
}
