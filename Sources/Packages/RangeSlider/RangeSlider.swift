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
    
    private let backgroundTrackColor: Color = Color(.secondarySystemFill)
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
                    .frame(width: sliderWidth(geo))
                
                Capsule()
                    .fill(selectedTrackColor)
                    .offset(x: minXPoint)
                    .frame(width: maxXPoint - minXPoint, height: 4)
                
                RangeSliderThumb()
                    .offset(x: minXPoint)
                    .gesture(DragGesture().onChanged { value in
                        if value.location.x > 0 && value.location.x <= sliderWidth(geo) && value.location.x <= maxXPoint {
                            minPercent = Float(value.location.x / sliderWidth(geo))
                            minXPoint = value.location.x
                        }
                    })
                
                RangeSliderThumb()
                    .offset(x: maxXPoint)
                    .gesture(DragGesture().onChanged { value in
                        if value.location.x <= sliderWidth(geo) && value.location.x >= minXPoint {
                            maxPercent = Float(value.location.x / sliderWidth(geo))
                            maxXPoint = value.location.x
                        }
                    })
            }
            .frame(width: sliderWidth(geo))
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                self.minXPoint = sliderWidth(geo) * CGFloat(minPercent)
                self.maxXPoint = sliderWidth(geo) * CGFloat(maxPercent)
            }
        }
    }
    
    private func sliderWidth(_ geo: GeometryProxy) -> CGFloat {
        geo.size.width * 0.9
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
        RangeSliderPreviewWrapper()
            .preferredColorScheme(.dark)
    }
}

private struct RangeSliderPreviewWrapper: View {
    @State var minPercent: Float = 0.25
    @State var maxPercent: Float = 0.75
    
    var body: some View {
        Form {
            Text("\(minPercent)-\(maxPercent)")
            RangeSlider(minPercent: $minPercent, maxPercent: $maxPercent)
            Slider(value: $minPercent, in: 0...1)
        }
    }
}
