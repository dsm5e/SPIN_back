//
//  DocumentScannerView.swift
//  Spin
//
//  Created by Golyakovph on 03.05.2023.
//
import SwiftUI

struct DocView: View {
    
    @StateObject var docVM = DocVM()
    @State var image: [UIImage]?
    @State var clientSearch = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: -10) {
                ForEach(docVM.clientData) { index in
                    NavigationLink(destination: DocClientView()) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(index.name.capitalized)
                                    .foregroundColor(.firstTtext)
                                Text(index.number)
                                    .foregroundColor(.firstTtext)
                            }
                            Spacer()
                            VStack(alignment: .center) {
                                Circle()
                                    .foregroundColor(index.documentLoad ? .green : .red)
                                    .frame(width: 15, height: 15)
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accent.opacity(0.9))
                        .cornerRadius(15)
                        .padding()
                    }
                }
            }
            .searchable(text: $clientSearch, placement: .automatic)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Документы")
        }
    }
}

struct Document_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DocView()
        }
    }
}
