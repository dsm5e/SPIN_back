//
//  SegmentedProgressBar.swift
//  Spin
//
//  Created by dsm 5e on 15.05.2023.
//
import SwiftUI

struct SegmentedProgressBar: View {
    var numberOfSegments = 6
    var activeSegment = 1
    
    var backgroundColor: Color
    var activeColor: Color
    
    init(numberOfSegments: Int, activeSegment: Int, backgroundColor: Color = Color.gray, activeColor: Color = Color.green) {
        self.numberOfSegments = numberOfSegments
        self.activeSegment = activeSegment
        self.backgroundColor = backgroundColor
        self.activeColor = activeColor
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(0..<numberOfSegments, id: \.self) { index in
                if index < numberOfSegments - 1 {
                    Circle()
                        .fill(index < activeSegment ? activeColor : .firstTtext)
                        .frame(width: 12, height: 12)
                        .offset(x: CGFloat(index) * 50)
                    Rectangle()
                        .fill(index < activeSegment ? activeColor : .firstTtext)
                        .frame(width: CGFloat(index) * 50, height: 2)
                }
            }
        }
    }
}

struct SegmentedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedProgressBar(numberOfSegments: 6, activeSegment: 3)
    }
}
