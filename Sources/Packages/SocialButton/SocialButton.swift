//
//  SocialButton.swift
//  RMSwiftUI
//

import SwiftUI

public struct SocialButton: View {
    
    private var action: () -> Void
    private var logo: Image
    
    public init(action: @escaping () -> Void, logo: Image) {
        self.action = action
        self.logo = logo
    }
    
    public var body: some View {
        Button(action: action, label: {
            logo
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .padding(.vertical, 32)
        }).buttonStyle(PlainButtonStyle())
    }
}
