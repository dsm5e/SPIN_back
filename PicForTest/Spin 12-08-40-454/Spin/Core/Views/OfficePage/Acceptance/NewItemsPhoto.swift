//
//  NewItemsPhoto.swift
//  Spin
//
//  Created by dsm 5e on 15.06.2023.
//

import SwiftUI
import PhotosUI

struct NewItemsPhoto: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var front = PhotoPickerSUI()
    @StateObject var back = PhotoPickerSUI()
    @StateObject var tag = PhotoPickerSUI()
    @State var name: String
    @State var size: String
    
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
                dismiss()
            } label: {
                PrimaryButton(title: "Отправить", showImage: false)
                    .padding(.top, 20)
            }
            Spacer()
        }
        .padding(.top, 25)
    }
}

struct NewItemsPhoto_Previews: PreviewProvider {
    static var previews: some View {
        NewItemsPhoto(name: "topchik", size: "XXXL")
    }
}
