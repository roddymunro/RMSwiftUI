//
//  ChangeIconGrid.swift
//  RMSwiftUI
//

import SwiftUI

#if !os(macOS)
public struct ChangeIconGrid: View {
    
    private var icons: [String]
    
    private var iconSize: CGFloat { return 60 }
    private var iconCorner: CGFloat { return 16 }
    
    public init(icons: [String]) {
        self.icons = icons
    }
    
    public var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: iconSize), spacing: 12)], spacing: 12) {
            ForEach(icons, id: \.self) { icon in
                Button(action: { changeIcon(to: icon) }, label: {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: iconCorner))
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private func changeIcon(to icon: String) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        UIApplication.shared.setAlternateIconName(icon, completionHandler: { (error) in
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }
}
#endif
