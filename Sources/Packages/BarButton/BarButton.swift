//
//  BarButton.swift
//  RMSwiftUI
//

import SwiftUI

public struct BarButton: View {
    private var iconName: String
    private var action: () -> Void
    
    public init(iconName: String, action: @escaping () -> Void) {
        self.iconName = iconName
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
        }
    }
}

public struct BarNavigationButton<Destination: View>: View {
    private var iconName: String
    private var destination: Destination
    
    public init(iconName: String, destination: Destination) {
        self.iconName = iconName
        self.destination = destination
    }
    
    public var body: some View {
        NavigationLink(destination: destination) {
            Image(systemName: iconName)
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
        }
    }
}
