//
//  SegmentedProgressBar.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//
import SwiftUI

struct SegmentedProgressBar: View {
    var numberOfSegments: Int
    var acceptanceItemStatus: Int
    var itemStatus: Int
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            ForEach(0..<numberOfSegments, id: \.self) { index in
                ZStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .offset(x: CGFloat(index) * 25)
                    Rectangle()
                        .frame(width: CGFloat(index) * 50, height: 2)
                        .offset(x: 5)
                }
                .foregroundColor(.firstTtext)
            }
        }
    }
}

struct SegmentedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedProgressBar(numberOfSegments: 6, acceptanceItemStatus: 2, itemStatus: 3)
    }
}
