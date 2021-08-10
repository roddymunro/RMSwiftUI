//
//  CardView.swift
//  RMSwiftUI
//

import SwiftUI

public struct CardView<Content>: View where Content: View {
    private var backgroundColor: Color
    private var content: () -> Content
    private var needsPadding: Bool
    private var fitToContent: Bool
    
    public init(backgroundColor: Color?=nil, needsPadding: Bool=true, fitToContent: Bool=false, content: @escaping () -> Content) {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        } else {
            #if !os(macOS)
            self.backgroundColor = Color(.systemGray6)
            #else
            self.backgroundColor = Color(.darkGray)
            #endif
        }
        
        self.needsPadding = needsPadding
        self.fitToContent = fitToContent
        self.content = content
    }

    public var body: some View {
        HStack {
            if needsPadding {
                content()
                    .padding()
            } else {
                content()
            }
            if !fitToContent {
                Spacer(minLength: 0)
            }
        }
        .cornerRadius(16)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
