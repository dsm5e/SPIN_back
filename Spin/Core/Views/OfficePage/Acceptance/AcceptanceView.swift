//
//  PriemkaView.swift
//  Spin
//
//  Created by Golyakovph on 24.04.2023.
//

import SwiftUI

struct AcceptanceView: View {
    @EnvironmentObject var vm: ApiService
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 15) {
                ForEach(vm.acceptances) { acceptance in
                    NavigationLink {
                        AcceptanceItemsView(id: acceptance.id)
                    } label: {
                        AcceptanceRow(
                            comitentID: acceptance.comitentID,
                            id1C: acceptance.id1C,
                            numberOfItems: acceptance.numberOfItems
                        )
                        .padding(.horizontal)
                    }
                }
            }
        }
        .task {
            await vm.fetchAcceptances()
        }
        .navigationBarTitle("ПРИЕМКИ", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ScanerView()) {
                    Image(systemName: "barcode.viewfinder")
                }
            }
        }
    }
}

struct PriemkaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AcceptanceView()
                .environmentObject(ApiService())
        }
    }
}
