//
//  PrimaryButtonStyle.swift
//  RMSwiftUI
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    
    @Binding private var showSpinner: Bool
    
    public init(showSpinner: Binding<Bool> = .constant(false)) {
        self._showSpinner = showSpinner
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Group {
            if showSpinner {
                ProgressView()
            } else {
                configuration.label
                    .textCase(.uppercase)
                    .foregroundColor(.white)
            }
        }
        .font(Font.body.weight(.semibold))
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color.accentColor.opacity(configuration.isPressed ? 0.7 : 1))
        .frame(height: 48)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .disabled(showSpinner)
    }
}
