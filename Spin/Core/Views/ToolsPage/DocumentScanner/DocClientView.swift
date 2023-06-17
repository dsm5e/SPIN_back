//
//  DocClientView.swift
//  Spin
//
//  Created by dsm 5e on 06.05.2023.
//

import SwiftUI
import VisionKit

struct DocClientView: View {
    @State var debugInfo: String = ""
    @State var images: [UIImage] = []
    @State var showsImage: Bool = false
    @State var currentImageId: Int = 0
    @State var showsScanner: Bool = false
    @Namespace var navigation
    
    var body: some View {
        VStack(spacing: 20) {
            if !showsImage {
                HStack(alignment: .center){
                    Spacer()
                    ResultImagesGrid(showsImage: $showsImage, images: $images, currentImageId: $currentImageId, namespace: navigation)
                    Spacer()
                    catchImageView(debugInfo: $debugInfo, showsScanner: $showsScanner)
                    Spacer()
                }
                Button("send image") {
                    if images.count > currentImageId { // закомментировано для демо
                        let image = images[currentImageId]
                        if let imageData = image.jpegData(compressionQuality: 0.8) {
                            Task {
                                do {
                                    try await ImageService.uploadComitentPhoto([.init(imageData: imageData, forKey: "1")])
                                } catch {
                                    debugInfo = error.localizedDescription
                                }
                            }
                        } else {
                            debugInfo = "Error: Failed to convert image to data"
                        }
                    }
                }
                Spacer()
            }
            else {
                FullScreenImage(showsImage: $showsImage, images: $images, currentImageId: $currentImageId, namespace: navigation)
            }
        }
        .padding()
        .sheet(isPresented: $showsScanner) {
            DocScan(results: $images) {
                showsScanner = false
                debugInfo = "Scan cancelled"
            } failedWith: { error in
                debugInfo = "\(error.localizedDescription)"
            }
            .edgesIgnoringSafeArea(.all)
        }
        .animation(.default, value: showsScanner)
    }
}


struct catchImageView: View {
    @Binding var debugInfo: String
    @Binding var showsScanner: Bool
    var body: some View {
        Button {
            debugInfo.removeAll()
            showsScanner = true
        } label: {
            Rectangle()
                .frame(width: 150, height: 200)
                .cornerRadius(20)
                .foregroundColor(.accent)
                .overlay {
                    CircleButton(iconName: "plus")
                        .foregroundColor(.firstTtext)
                }
        }
    }
}

struct FullScreenImage: View {
    @Binding var showsImage: Bool
    @Binding var images: [UIImage]
    @Binding var currentImageId: Int
    let namespace: Namespace.ID
    var body: some View {
        Group {
            if images.count > 0 {
                Image(uiImage: images[currentImageId])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture(count: 1, perform: {
                        showsImage.toggle()
                    })
                    .matchedGeometryEffect(id: "image\(currentImageId)", in: namespace)
            }
        }
    }
}

struct ResultImagesGrid: View {
    @Binding var showsImage: Bool
    @Binding var images: [UIImage]
    @Binding var currentImageId: Int
    var rows: [GridItem] = [ GridItem(.fixed(100), spacing: 15, alignment: .center) ]
    let namespace: Namespace.ID
    var body: some View {
        TabView {
            ForEach(0..<images.count, id: \.self) { index in
                Image(uiImage: images[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaledToFill()
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        currentImageId = index
                        showsImage.toggle()
                    })
                    .matchedGeometryEffect(id: "image\(index)", in: namespace)
            }
        }
        .tabViewStyle(.page)
        .background(Color.accentColor)
        .cornerRadius(20)
        .frame(width: 150, height: 200)
    }
}

struct DocClientView_Previews: PreviewProvider {
    static var previews: some View {
        DocClientView()
    }
}
