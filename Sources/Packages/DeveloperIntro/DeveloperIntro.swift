//
//  DeveloperIntro.swift
//  
//
//  Created by Roddy Munro on 2021-08-31.
//

import SwiftUI

public struct DeveloperIntro: View {
    
    private let profileImage: Image
    private let bio: String
    private let actionButton: DeveloperIntro.Button?
    
    public init(profileImage: Image, bio: String, actionButton: DeveloperIntro.Button?=nil) {
        self.profileImage = profileImage
        self.bio = bio
        self.actionButton = actionButton
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("Meet The Developer")
                .font(.title2.weight(.bold))
            
            profileImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 72, height: 72)
                .background(Color(.secondarySystemBackground))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
            
            Divider()
            
            Text(bio)
                .font(.system(.callout, design: .monospaced))
                .multilineTextAlignment(.center)
            
            if let button = actionButton {
                SwiftUI.Button(action: button.action, label: {
                    Label(button.title, systemImage: button.systemImage)
                })
            }
        }.padding()
    }
}

extension DeveloperIntro {
    public struct Button{
        public let action: () -> ()
        public let title: String
        public let systemImage: String
        
        init(action: @escaping ()->(), title: String, systemImage: String) {
            self.action = action
            self.title = title
            self.systemImage = systemImage
        }
    }
}

struct DeveloperIntro_Previews: PreviewProvider {
    
    static var previews: some View {
        Form {
            Section {
                DeveloperIntro(
                    profileImage: Image("DeveloperImage", bundle: .module),
                    bio: "Hello, my name is Roddy, and I am the developer of this app.",
                    actionButton: .init(action: {}, title: "Open Website", systemImage: "globe")
                )
            }
        }
        .preferredColorScheme(.dark)
    }
}
