//
//  StyledLabel.swift
//  RMSwiftUI
//

import SwiftUI
import RMSwiftUICore

public struct StyledLabel: View {
    
    private let text: String
    private let icon: String
    private let block: Bool
    private let style: Font
    private let weight: Font.Weight
    private let iconColor: Color
    
    public init(_ text: String, icon: String, block: Bool = false, style: Font = .body, weight: Font.Weight = .regular, iconColor: Color = .accentColor) {
        self.text = text
        self.icon = icon
        self.block = block
        self.style = style
        self.weight = weight
        self.iconColor = iconColor
    }
    
    public var body: some View {
        Group {
            if block {
                Label(
                    title: { Text(text)
                        .font(style)
                        .fontWeight(weight)
                    },
                    icon: {
                        Image(systemName: icon)
                            .foregroundColor(.white)
                            .background(
                                iconColor.edgesIgnoringSafeArea(.all)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .frame(width: 28, height: 28)
                            )
                    }
                )
            } else {
                Label(text, systemImage: icon)
                    .font(style.weight(weight))
                    .accentColor(iconColor)
            }
        }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cell.edgesIgnoringSafeArea(.all))
    }
}
