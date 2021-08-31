//
//  SettingsRow.swift
//  RMSwiftUI
//

import SwiftUI
import RMStyledLabel

public struct SettingsRow: View {
    private let icon: String
    private let text: String
    private let action: () -> Void
    private let block: Bool
    private let iconColor: Color
    
    public init(icon: String, text: String, action: @escaping () -> Void, block: Bool=false, iconColor: Color = .accentColor) {
        self.icon = icon
        self.text = text
        self.action = action
        self.block = block
        self.iconColor = iconColor
    }

    public var body: some View {
        Button(action: action) {
            StyledLabel(text, icon: icon, block: block, iconColor: iconColor)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibility(identifier: "\(text.filter { !$0.isWhitespace })Row")
    }
}
