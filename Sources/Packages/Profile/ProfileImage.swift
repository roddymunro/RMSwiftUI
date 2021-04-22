//
//  ProfileImage.swift
//  PlateItiOS
//
//  Created by Roddy Munro on 30/01/2021.
//

import SwiftUI

public struct ProfileImage: View {
    
    @Binding private var image: UIImage?
    private var size: CGFloat
    
    public init(image: Binding<UIImage?>, size: CGFloat) {
        self._image = image
        self.size = size
    }
    
    public var body: some View {
        if image != nil {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
                .imageScale(.large)
                .foregroundColor(Color.init(.systemGray))
        }
    }
}
