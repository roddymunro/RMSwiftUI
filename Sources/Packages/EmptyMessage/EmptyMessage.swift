//
//  EmptyMessage.swift
//  RMSwiftUI
//
//  Created by Roddy Munro on 06/09/2020.
//  Copyright © 2020 roddy.io. All rights reserved.
//

import SwiftUI

public struct EmptyMessage: View {
    
    private var imageName: String?
    private var title: String
    private var message: String
    private var button: EmptyMessage.Button?
    
    public init(imageName: String?=nil, title: String, message: String, button: EmptyMessage.Button?=nil) {
        self.imageName = imageName
        self.title = title
        self.message = message
        self.button = button
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Spacer()
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 192, height: 192)
            }
            Text(title)
                .font(Font.title.weight(.bold))
                .frame(maxWidth: .infinity)
            Text(message)
            if let button = button {
                SwiftUI.Button(button.title, action: button.action)
            }
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(EdgeInsets(top: 8, leading: 48, bottom: 8, trailing: 48))
    }
    
    public struct Button {
        public var title: String
        public var action: ()->()
        
        public init(title: String, action: @escaping ()->()) {
            self.title = title
            self.action = action
        }
    }
}
