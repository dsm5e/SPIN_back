//
//  RootView.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct RootView: View {
    @State var selectedTab: Tabs = .office
    
    var body: some View {
        VStack(alignment: .center) {
            selectedTab.view
                .transition(.opacity.animation(.easeInOut))
            Spacer()
            TabBarView(selectedTab: $selectedTab)
        }
        .navigationBarHidden(true)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            RootView()
        }
    }
}
