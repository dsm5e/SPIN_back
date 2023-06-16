//
//  ItemFieldView.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import SwiftUI

struct ItemFieldView: View {
    @State private var isOptionsPresented: Bool = false
    @State var item: ItemModel1C

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                TextField("Название", text: $item.name)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .padding(.horizontal)
                DropdownMenu(
                    selectedOption: .constant(nil),
                    placeholder: "Категория",
                    options: DropdownMenuOption.testAllMonths
                )
                DropdownMenu(
                    selectedOption: .constant(nil),
                    placeholder: "Размер",
                    options: DropdownMenuOption.testAllMonths
                )
                DropdownMenu(
                    selectedOption: .constant(nil),
                    placeholder: "Бренд",
                    options: DropdownMenuOption.testAllMonths
                )
                DropdownMenu(
                    selectedOption: .constant(nil),
                    placeholder: "Стиль",
                    options: DropdownMenuOption.testAllMonths
                )
                DropdownMenu(
                    selectedOption: .constant(nil),
                    placeholder: "Состояние",
                    options: DropdownMenuOption.testAllMonths
                )
                Spacer()
            }
            .padding(.top,30)
        }
        .navigationTitle("Редактор карточки")
    }
}

struct ItemFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemFieldView(item: .init(id: "", id1C: "", name: "", category: [], brand: [], style: "", size: "", condition: "", prices: [], images: [], descriptions: [], createdAt: "", updatedAt: "", acceptance: ""))
        }
    }
}
