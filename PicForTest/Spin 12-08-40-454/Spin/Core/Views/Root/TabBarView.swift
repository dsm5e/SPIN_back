//
//  TabBar.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

enum Tabs: Int, CaseIterable {
    case office = 0
    case scaner = 1
    case acceptance = 2
    case task = 3
    case client = 4
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .office:
            OfficeView()
        case .scaner:
            ToolsView()
        case .acceptance:
            AcceptanceView()
        case .task:
            TaskView()
        case .client:
            ClientView()
        }
    }
    
    var tabTitle: String {
        switch self {
        case .office:
            return "Офис"
        case .scaner:
            return "Фичи"
        case .acceptance:
            return "Приемка"
        case .task:
            return "Задачи"
        case .client:
            return "Клиенты"
        }
    }
    
    var imageName: String {
        switch self {
        case .office:
            return "figure.wave"
        case .scaner:
            return "u.square"
        case .acceptance:
            return "plus.app.fill"
        case .task:
            return "bell.fill"
        case .client:
            return "bubble.left"
        }
    }
}

struct TabBarView: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(Tabs.allCases, id: \.self) { tabItem in
                Button {
                    selectedTab = tabItem
                } label: {
                    TabBarButton(
                        buttonText: tabItem.tabTitle,
                        imageName: tabItem.imageName,
                        isActive: selectedTab == tabItem
                    )
                }
            }
        }
        .frame(height: 60)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.office))
    }
}
