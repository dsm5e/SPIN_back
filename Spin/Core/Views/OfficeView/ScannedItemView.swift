//
//  ScannedItemView.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//

import SwiftUI

struct ScannedItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    let scannedItemInfo: ItemModel1C
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.accent)
                            .frame(width: 30, height: 30)
                        Spacer()
                    }
                }
                Text(scannedItemInfo.id1C)
                    .font(.title)
                Text(scannedItemInfo.name)
                    .font(.headline)
                HStack {
                    Rectangle()
                        .fill(Color.secondaryText)
                        .frame(width: 100, height: 150)
                        .cornerRadius(20)
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Бренд ")
                                .font(.callout)
                            // Собираем все бренды в одну строку через запятую
//                            Text(scannedItemInfo.brand.reduce(into: "", { partialResult, item in
//                                partialResult += item.name + ", "
//                            })).bold()
                            Text(scannedItemInfo.brand.first?.name ?? "В обработке").bold()
                        }
                        HStack {
                            Text("Цена ")
                                .font(.callout)
                            Text(scannedItemInfo.prices.first?.value.description ?? "В обработке")
                                .bold()
                        }
                        HStack {
                            Text("PAYOUT ")
                                .font(.callout)
                            Text("В обработке")
                                .bold()
                        }
                        HStack {
                            Text("Дата поступления")
                                .font(.callout)
                            Text("14.05.2023")
                                .bold()
                        }
                    }.padding()
                }
                .padding()
                NavigationLink {
                    ItemFieldView(item: scannedItemInfo)
                } label: {
                    PrimaryButton(title: "Редактировать", showImage: false)
                }
                Spacer()
            }
            .padding()
        }
    }
}


struct ScannedItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedItemView(scannedItemInfo: .init(id: "", id1C: "", name: "", category: [], brand: [], style: "", size: "", condition: "", prices: [], images: [], descriptions: [], createdAt: "", updatedAt: "", acceptance: ""))
    }
}
