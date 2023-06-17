//
//  ClientView.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct ClientView: View {
    var body: some View {
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("Клиенты")
    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ClientView()
        }
    }
}
