//
//  AcceptancesItemRow.swift
//  Spin
//
//  Created by dsm 5e on 25.05.2023.
//

import SwiftUI


struct AcceptanceItemRow: View {
    var id: String
    var brand: String
    var name: String
    var condition: String
    var size: String
    var category: String
    var dayInStock: Int
    var price: Int
    var status: String
    
    var body: some View {
        let urlImage = URL(string: "https://server.spin4spin.com/images/2000000233178/2000000233178-4efa0653454e915364cd8591dba6e12f.jpg")
        
        HStack(alignment: .center, spacing: 8) {
            VStack {
                HStack {
                    AsyncImage(url: urlImage) { returnedImage in
                        returnedImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 100)
                            .cornerRadius(10)
                            .padding(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 70, height: 100)
                            .padding(8)
                    }
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(brand)
                                    .font(.headline)
                                Text(name)
                                    .font(.subheadline)
                                    .bold()
                                Text(condition)
                                    .font(.subheadline)
                                Text(size)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Spacer()
                            VStack {
                                Text("Статус:")
                                Text(status)
                                    .bold()
                                Text("Цена:")
                                Text(price.description)
                                    .bold()
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.firstTtext)
        )
        .padding(.horizontal)
    }
}

struct AcceptancesItemRow_Previews: PreviewProvider {
    static var previews: some View {
        AcceptanceItemRow(id: "asflfsalmf", brand: "Rick Owens", name: "Lapti", condition: "BNWT", size: "XL", category: "Shoes", dayInStock: 9, price: 20000, status: "Priemka")
            .previewLayout(.sizeThatFits)
    }
}
