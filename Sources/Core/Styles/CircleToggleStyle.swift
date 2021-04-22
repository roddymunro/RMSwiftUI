//
//  CircleToggleStyle.swift
//  RMSwiftUI
//

import SwiftUI

public struct CircleToggleStyle: ToggleStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label.hidden()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                .imageScale(.large)
                .font(Font.title)
        }
    }
}
