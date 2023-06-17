//
//  ItemEditorView.swift
//  Spin
//
//  Created by dsm 5e on 25.05.2023.
//

import SwiftUI

struct ItemEditorView: View {
    @EnvironmentObject var vm: ApiService
    @Environment(\.dismiss) var dismiss
    @State var item: ItemModel1C
    @State private var brandQuery = ""
    @State private var categoryQuery = ""
    @State private var isBrandActive = false
    @State private var isCategoryActive = false
    @State var showsScanner: Bool = false
    @State var images: [UIImage] = []
    @State var int: Int = 0

    
    
    /// Отфильтрованные бренды по `brandQuery`
    private var filteredBrands: [Brand] {
        brandQuery.isEmpty
        ? vm.brands
        : vm.brands.filter { brand in
            brand.name.lowercased().contains(brandQuery.lowercased())
        }
    }
    
    /// Отфильтрованные категории по `categoryQuery`
    private var filteredCategories: [Brand] {
        categoryQuery.isEmpty
        ? vm.categories
        : vm.categories.filter { category in
            category.name.lowercased().contains(categoryQuery.lowercased())
        }
    }
    
    private var canSaveItem: Bool {
        vm.selectedBrand != nil && vm.selectedCategory != nil
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                
                TextField("Название", text: $item.name)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                VStack(spacing: 0) {
                    TextField("Введи бренд", text: $brandQuery) { isEditing in
                        isBrandActive = isEditing
                    }
                    .padding()
                    
                    if isBrandActive {
                        ForEach(filteredBrands.prefix(3)) { brand in
                            Button(action: {
                                print("выбрали категорию: \(brand.name)")
                                vm.selectBrand(brand)
                            }) {
                                Text(brand.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.body)
                                    .padding(.all)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isBrandActive ? Color.gray.opacity(0.8) : Color.gray, lineWidth: 2)
                }
                .padding(.horizontal)
                .onChange(of: vm.selectedBrand) { brand in
                    if let brand { brandQuery = brand.name }
                    isBrandActive = false
                }
                
                HStack {
                    VStack(spacing: 0) {
                        TextField("Введи категорию", text: $categoryQuery) { isEditing in
                            isCategoryActive = isEditing
                        }
                        .padding()
                        
                        if isCategoryActive {
                            ForEach(filteredCategories.prefix(3)) { category in
                                Button(action: {
                                    print("выбрали категорию: \(category.name)")
                                    vm.selectCategory(category)
                                }) {
                                    Text(category.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.body)
                                        .padding(.all)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 2)
                    }
                    .onChange(of: vm.selectedCategory) { category in
                        if let category { categoryQuery = category.name }
                        isCategoryActive = false
                    }
                    Button {
                        showsScanner.toggle()
                    } label: {
                        Image(systemName: "camera.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $showsScanner) {
                    DocScan(results: $images) {
                        showsScanner = false
                    } failedWith: { error in
                        print(error.localizedDescription)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }

                TextField("Размер", text: $item.size)
                    .foregroundColor(.accent)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .padding(.horizontal)
                TextField("Стиль", text: $item.style)
                    .foregroundColor(.accent)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .padding(.horizontal)
                TextField("Состояние", text: $item.condition)
                    .foregroundColor(.accent)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .padding(.horizontal)

                TextField("Цена", value: $item.prices.first?.value ?? $int, format: .number)
                    .foregroundColor(.accent)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.gray, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                Button {
                    Task {
                        await vm.update1cItem(id: item.id1C, item: item)
                        dismiss()
                    }
                } label: {
                    PrimaryButton(title: "Сохранить", showImage: false)
                }
                .disabled(!canSaveItem)
            }
            .task {
                await vm.getBrands()
                await vm.getCategories()
            }
            .padding(.top, 20)
        }
        .navigationTitle("Редактор карточки")
    }
}

struct ItemEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemEditorView(item: .init(id: "123", id1C: "123", name: "123", categories: [], brands: [], style: "", size: "", condition: "", prices: [], images: [], descriptions: [], createdAt: "", updatedAt: "", acceptance: "", staffPhoto: "", status: ""))
                .environmentObject(ApiService())
        }
    }
}
