//
//  ProfileView.swift
//  
//
//  Created by Roddy Munro on 21/12/2020.
//

import SwiftUI

public struct ProfileView: View {
    
    @Binding var fullName: String
    @Binding var expirationDate: String
    
    #if !os(macOS)
    @Binding var profileImage: UIImage?
    
    public init(fullName: Binding<String>, expirationDate: Binding<String>, profileImage: Binding<UIImage?>) {
        self._fullName = fullName
        self._expirationDate = expirationDate
        self._profileImage = profileImage
    }
    #else
    @Binding var profileImage: NSImage?
    
    public init(fullName: Binding<String>, expirationDate: Binding<String>, profileImage: Binding<NSImage?>) {
        self._fullName = fullName
        self._expirationDate = expirationDate
        self._profileImage = profileImage
    }
    #endif
    
    private var image: Image {
        #if !os(macOS)
        return Image(uiImage: profileImage!)
        #else
        return Image(nsImage: profileImage!)
        #endif
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ProfileImage(image: $profileImage, size: 56)
            VStack(alignment: .leading, spacing: 0) {
                Text(fullName)
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(expirationDate)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

