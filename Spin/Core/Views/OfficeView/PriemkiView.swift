//
//  PriemkaView.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct PriemkiView: View {
    @StateObject var vm = PriemkiVM()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(vm.lists) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            SegmentedProgressBar(numberOfSegments: 6, activeSegment: 1)
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("\(item.comitentId)")
                                    //                            Text("Имя комитента")
                                    Text("+7(980) xxxx xx")
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
                                            Text("\(item.id1c)")
                                                .font(.caption)
                                                .bold()
                                            Text("Номер")
                                                .font(.caption)
                                        }
                                    }
                                    .padding(.trailing, 40)
                                }
                            }
                        }
                        Divider()
                            .frame(width: 2, height: 100)
                            .background(Color.firstTtext)
                        VStack {
                            Text("\(item.numberOfItems)")
                            //                    Text("23")
                            Text("товаров")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.firstTtext)
                    .padding()
                    .background(
                        Rectangle()
                            .foregroundColor(.accent)
                            .cornerRadius(20)
                            .shadow(color: Color.accentColor.opacity(0.5), radius: 5)
                    )
                    .padding()
                }
            }
            .animation(.default, value: vm.lists.count)
        }
        .task { await vm.getPosts() }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ScanerView()) {
                    Image(systemName: "barcode.viewfinder")
                }
            }
        }
        .navigationBarTitle("ПРИЕМКИ", displayMode: .inline)
        .frame(maxWidth: .infinity)
        
    }
}


struct PriemkaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PriemkiView()
        }
    }
}



