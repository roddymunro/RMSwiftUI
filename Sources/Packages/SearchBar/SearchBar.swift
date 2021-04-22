//
//  SearchBar.swift
//  RMSwiftUI
//
//  Created by Roddy Munro on 21/08/2020.
//  Copyright © 2020 roddy.io. All rights reserved.
//

import SwiftUI
import RMSwiftUICore

public struct SearchBar: View {
    private var placeholder: String
    @Binding private var text: String
    
    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    private var foregroundColor: Color {
        #if !os(macOS)
        return Color(.systemGray3)
        #else
        return Color(.gray)
        #endif
    }
    
    private var backgroundColor: Color {
        #if !os(macOS)
        return .background
        #else
        return Color(.darkGray)
        #endif
    }
  
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField(placeholder, text: $text)
            if text != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(foregroundColor)
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.text = ""
                        }
                    }
            }
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(12)
        .padding(.vertical, 10)
    }
}
