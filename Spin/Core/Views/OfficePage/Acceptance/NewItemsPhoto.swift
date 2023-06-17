//
//  NewItemsPhoto.swift
//  Spin
//
//  Created by dsm 5e on 15.06.2023.
//

import SwiftUI
import PhotosUI
import Alamofire

struct NewItemsPhoto: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var front = PhotoPickerSUI()
    @StateObject var back = PhotoPickerSUI()
    @StateObject var tag = PhotoPickerSUI()
    @State var name: String
    @State var size: String
    @State var id: String
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Выбери фото")
                    .font(.largeTitle)
                Text("из галереии")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                Text(name)
                    .font(.headline)
                Text(size)
                    .font(.subheadline)
                    .padding(.bottom, 20)
                
                HStack(spacing: 20) {
                    PhotosPicker(selection: $front.imageSelection, matching: .images, photoLibrary: .shared()) {
                        if let image = front.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.1))
                                .cornerRadius(15)
                                .overlay {
                                    Text("ФРОНТ")
                                        .foregroundColor(.accentColor)
                                }
                                .frame(width: 90, height: 120)
                        }
                    }
                    
                    PhotosPicker(selection: $back.imageSelection, matching: .images, photoLibrary: .shared()) {
                        if let image = back.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.1))
                                .cornerRadius(15)
                                .overlay {
                                    Text("ЗАД")
                                        .foregroundColor(.accentColor)
                                }
                                .frame(width: 90, height: 120)
                        }
                    }
                    PhotosPicker(selection: $tag.imageSelection, matching: .images, photoLibrary: .shared()) {
                        if let image = tag.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Rectangle()
                                .foregroundColor(.gray.opacity(0.1))
                                .cornerRadius(15)
                                .overlay {
                                    Text("ТЭГ")
                                        .foregroundColor(.accentColor)
                                }
                                .frame(width: 90, height: 120)
                        }
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button {
                if let image = front.uiImage {
                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        Task {
                            do {
                                AF.upload(multipartFormData: { multipartFormData in
                                    multipartFormData.append(imageData, withName: "photo1")
                                }, to: "https://cms.spin4spin.com/api/items/add-image?id=\(id)")
                                    .responseDecodable(of: ItemModel1C.self) { response in
                                    }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                dismiss()
            } label: {
                PrimaryButton(title: "Отправить", showImage: false)
            }
            Spacer()
        }
        .padding(.top, 25)
    }
}

struct NewItemsPhoto_Previews: PreviewProvider {
    static var previews: some View {
        NewItemsPhoto(name: "topchik", size: "XXXL", id: "1234124")
    }
}
