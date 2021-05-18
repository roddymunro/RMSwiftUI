//
//  File.swift
//  
//
//  Created by Roddy Munro on 2021-04-26.
//

import SwiftUI

public struct MinorButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
            .multilineTextAlignment(.center)
            .font(Font.callout.weight(.semibold))
            .padding(.vertical, 4)
            .padding(.horizontal, 24)
            .background(Color.accentColor.opacity(configuration.isPressed ? 0.1 : 0.01))
            .frame(height: 24)
            .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}
