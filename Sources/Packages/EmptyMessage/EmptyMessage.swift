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
    
    public init(imageName: String?=nil, title: String, message: String) {
        self.imageName = imageName
        self.title = title
        self.message = message
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
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(EdgeInsets(top: 8, leading: 48, bottom: 8, trailing: 48))
    }
}
