//
//  AcceptanceItemsList.swift
//  Spin
//
//  Created by Олег Еременко on 23.05.2023.
//

import SwiftUI

struct AcceptanceItemsView: View {
    @EnvironmentObject var vm: ApiService
    let id: String
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                ForEach(vm.acceptanceItems) { item in
                    NavigationLink {
                        ItemView(id1c: item.id1C)
                    } label: {
                        AcceptanceItemRow(
                            id: item.id,
                            brand: item.brands.first?.name ?? "Нет бренда",
                            name: item.name,
                            condition: item.condition,
                            size: item.size,
                            category: item.categories.first?.name ?? "Нет категории",
                            dayInStock: 8,
                            price: item.prices.first?.value ?? 0,
                            status: item.status.lowercased()
                        )
                    }
                }
            }
        }
        .task {
            await vm.fetchAcceptanceItems(id: id)
        }
        .navigationTitle("Список вещей")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AcceptanceItemsList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AcceptanceItemsView(id: "clhoozwsv001einygwhfz2vf9")
                .environmentObject(ApiService())
        }
    }
}
