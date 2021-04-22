//
//  StepProgressView.swift
//  RMSwiftUI
//

import SwiftUI

public struct StepProgressView: View {
    
    @Binding var currentIndex: Int
    var max: Int
    
    public init(currentIndex: Binding<Int>, max: Int) {
        self._currentIndex = currentIndex
        self.max = max
    }
    
    public var body: some View {
        HStack {
            ForEach(0..<max) { i in
                Circle()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundColor(currentIndex >= i ? Color.accentColor : Color(.systemGray))
            }
        }
    }
}
