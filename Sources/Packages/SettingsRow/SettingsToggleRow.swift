//
//  SettingsToggleRow.swift
//  
//
//  Created by Roddy Munro on 2021-08-18.
//

import SwiftUI
import RMStyledLabel

public struct SettingsToggleRow: View {
    private let icon: String
    private let text: String
    @Binding private var toggledOn: Bool
    private let block: Bool
    private let iconColor: Color
    
    public init(icon: String, text: String, toggledOn: Binding<Bool>, block: Bool=false, iconColor: Color = .accentColor) {
        self.icon = icon
        self.text = text
        self._toggledOn = toggledOn
        self.block = block
        self.iconColor = iconColor
    }

    public var body: some View {
        Toggle(isOn: $toggledOn, label: {
            StyledLabel(text, icon: icon, block: block, iconColor: iconColor)
        })
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            .accessibility(identifier: "\(text.filter { !$0.isWhitespace })Row")
    }
}

struct SettingsToggleRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Form {
            Section {
                SettingsToggleRow(icon: "flame", text: "Toggle me!", toggledOn: .constant(true))
                SettingsToggleRow(icon: "flame", text: "Toggle me!", toggledOn: .constant(false))
            }
        }
    }
}
