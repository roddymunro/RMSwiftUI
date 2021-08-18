//
//  SettingsNavigationRow.swift
//  
//
//  Created by Roddy Munro on 2021-08-18.
//

import SwiftUI
import RMStyledLabel

public struct SettingsNavigationRow<Content: View>: View {
    private let icon: String
    private let text: String
    private let destination: Content
    private let block: Bool
    private let iconColor: Color
    
    public init(icon: String, text: String, destination: Content, block: Bool=false, iconColor: Color = .accentColor) {
        self.icon = icon
        self.text = text
        self.destination = destination
        self.block = block
        self.iconColor = iconColor
    }

    public var body: some View {
        NavigationLink(destination: destination) {
            StyledLabel(text, icon: icon, block: block, iconColor: iconColor)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibility(identifier: "\(text.filter { !$0.isWhitespace })NavRow")
    }
}
