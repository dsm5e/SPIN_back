//
//  ItemView.swift
//  Spin
//
//  Created by dsm 5e on 25.05.2023.
//

import SwiftUI

struct ItemView: View {
    
    @EnvironmentObject var vm: ApiService
    @State private var showImagePicker = false
    @State private var showNewItems = false
    @State private var image: UIImage?
    
//    let urlImage = URL(string: "https://cms.spin4spin.com/\(vm.item1C?.staffPhoto)")
    
    let id1c: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(vm.item1C?.id1C ?? "нет айди")
                    .font(.title)
                    .bold()
                ZStack {
                    Text(vm.item1C?.name ?? "нет имени")
                        .font(.headline)
                    HStack {
                        Spacer()
                        NavigationLink {
                            if let item = vm.item1C {
                                ItemEditorView(item: item)
                            }
                        } label: {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        }
                    }
                    .padding(.trailing, 30)
                }
                
                TabView {
                    AsyncImage(url: URL(string: "https://cms.spin4spin.com/api/\(vm.item1C?.staffPhoto ?? "")")) { returnedImage in
                        returnedImage
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                    } placeholder: {
                        ProgressView()
                    }
                }
                .tabViewStyle(.page)
                .padding(.horizontal, 30)
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text("Бренд:")
                                .font(.callout)
                            Spacer()
                            Text(vm.item1C?.brands.first?.name ?? "Нет бренда")
                                .font(.callout)
                                .bold()
                        }
                        HStack {
                            Text("Цена:")
                                .font(.callout)
                            Spacer()
                            Text(vm.item1C?.prices.first?.value.description ?? "В обработке")
                                .font(.callout)
                                .bold()
                        }
                        HStack {
                            Text("PAYOUT:")
                                .font(.callout)
                            Spacer()
                            Text(vm.item1C?.prices.first?.name ?? "В обработке")
                                .font(.callout)
                                .bold()
                        }
                        HStack {
                            Text("Размер:")
                                .font(.callout)
                            Spacer()
                            Text(vm.item1C?.size ?? "В обработке")
                                .font(.callout)
                                .bold()
                        }
                        HStack {
                            Text("Дата поступления:")
                                .font(.footnote)
                            Spacer()
                            Text(vm.item1C?.createdAt.convertToDisplayFormat() ?? "В обработке")
                                .font(.callout)
                                .bold()
                        }
                        HStack {
                            Text("Дней в стоке:")
                                .font(.footnote)
                            Spacer()
                            Text(vm.item1C?.createdAt.daysSinceCreatedAt() ?? "В обработке")
                                .font(.callout)
                                .bold()
                        }
                        HStack {
                            Text("Статус:")
                                .font(.footnote)
                            Spacer()
                            Text(vm.item1C?.status ?? "В обработке")
                                .font(.callout)
                                .bold()
                        }
                    }.padding()
                }
                .padding()
                Button {
                    showNewItems.toggle()
                } label: {
                    PrimaryButton(title: "NEW ITEMS PHOTO", showImage: false)
                }
                .sheet(isPresented: $showNewItems) {
                    NewItemsPhoto(name: vm.item1C?.name ?? "Без названия", size: vm.item1C?.size ?? "Нет размера")
                        .presentationDetents([.fraction(0.57)])
                }
                Spacer()
            }
            .padding()
        }
        .task {
            Task {
                await vm.get1cItem(id: id1c)
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(id1c: "3000000130907") //превью с фото
//        ItemView(id1c: "30000004849") //превью без фото

            .environmentObject(ApiService())
    }
}
