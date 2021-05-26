//
//  ContentView.swift
//  RangeSliderTest
//
//  Created by Roddy Munro on 25/05/2021.
//

import SwiftUI

public struct RangeSlider: View {
    @Binding var minPercent: Float
    @Binding var maxPercent: Float
    
    @State private var minXPoint: CGFloat = 0
    @State private var maxXPoint: CGFloat = 0
    
    private let backgroundTrackColor: Color = Color(.systemGray5)
    private let selectedTrackColor: Color = Color.accentColor
    
    public init(minPercent: Binding<Float>, maxPercent: Binding<Float>) {
        self._minPercent = minPercent
        self._maxPercent = maxPercent
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(backgroundTrackColor)
                    .frame(height: 4)
                    .frame(width: geo.size.width)
                
                Capsule()
                    .fill(selectedTrackColor)
                    .offset(x: minXPoint)
                    .frame(width: maxXPoint - minXPoint, height: 4)
                
                RangeSliderThumb()
                    .offset(x: minXPoint)
                    .gesture(DragGesture().onChanged { value in
                        if value.location.x > 0 && value.location.x <= geo.size.width && value.location.x <= maxXPoint {
                            minPercent = Float(value.location.x / geo.size.width)
                            minXPoint = value.location.x
                        }
                    })
                
                RangeSliderThumb()
                    .offset(x: maxXPoint)
                    .gesture(DragGesture().onChanged { value in
                        if value.location.x + 20 <= geo.size.width && value.location.x >= minXPoint {
                            maxPercent = Float((value.location.x + 20) / geo.size.width)
                            maxXPoint = value.location.x
                        }
                    })
            }.onAppear {
                self.minXPoint = geo.size.width * CGFloat(minPercent)
                self.maxXPoint = geo.size.width * CGFloat(maxPercent)
            }
        }
    }
}

private struct RangeSliderThumb: View {
    
    private let thumbFillColor: Color = .white
    private let shadowColor: Color = Color(.systemGray4)
    
    var body: some View {
        Circle()
            .fill(thumbFillColor)
            .frame(width: 26, height: 26)
            .background(Circle().stroke(Color(.systemGray6), lineWidth: 1))
            .shadow(color: shadowColor, radius: 3, x: 0, y: 3)
    }
}

struct RangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        RangeSlider(minPercent: .constant(0.25), maxPercent: .constant(0.75))
    }
}
