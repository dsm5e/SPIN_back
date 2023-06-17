//
//  AcceptanceRowView.swift
//  Spin
//
//  Created by dsm 5e on 23.05.2023.
//

import SwiftUI

struct AcceptanceRow: View {
    let comitentID: String
    let id1C: String
    let numberOfItems: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                SegmentedProgressBar(numberOfSegments: 6, acceptanceItemStatus: 2, itemStatus: 2)
                    .padding(.top, 5)
                    .padding(.trailing, 3)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(comitentID)
                        Text("+7(xxx) xxxx xx")
                            .font(.caption)
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Text("PAYOUT")
                            .font(.headline)
                        Spacer()
                        HStack {
                            VStack {
                                Text("99")
                                    .font(.caption)
                                    .bold()
                                Text("дня в стоке")
                                    .font(.caption)
                            }
                            VStack {
                                Text(id1C)
                                    .font(.caption)
                                    .bold()
                                Text("Номер")
                                    .font(.caption)
                            }
                        }
                        .padding(.trailing, 10)
                    }
                }
            }
            Divider()
                .frame(width: 2, height: 100)
                .background(Color.firstTtext)
            VStack {
                Text("\(numberOfItems)")
                    .font(.headline)
                    .bold()
                Text((numberOfItems) < 3 ? "товара" : "товаров" )
                    .font(.caption)
            }
        }
        .foregroundColor(.firstTtext)
        .padding()
        .background(
            Rectangle()
                .foregroundColor(.accent)
                .cornerRadius(20)
                .shadow(color: Color.accentColor.opacity(0.5), radius: 5)
        )
    }
}

struct AcceptanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AcceptanceRow(
                comitentID: "123123",
                id1C: "123123",
                numberOfItems: 2
            )
            AcceptanceRow(
                comitentID: "123123",
                id1C: "123123",
                numberOfItems: 5
            )
        }
        .padding()
    }
}
