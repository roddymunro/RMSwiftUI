//
//  CloseButton.swift
//  
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI

public struct CloseButton: View {
    private let action: () -> ()
    
    public init(action: @escaping () -> ()) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .padding(.all, 10)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
        }
    }
}
