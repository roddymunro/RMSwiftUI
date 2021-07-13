//
//  SlideshowImageGridItem.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMSwiftUICore

struct SlideshowImageGridItem: View {
    
    @Binding var images: [UIImage?]
    
    let index: Int
    let imageSize: CGSize
    let maximumImagesToShow: Int?
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            if index < images.count, let image = images[index] {
                if index < maximumImagesToShow ?? Int.max {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageSize.width, height: imageSize.height)
                        .cornerRadius(cornerRadius)
                }
                
                if let maximumImagesToShow = maximumImagesToShow, images.count > maximumImagesToShow && index == maximumImagesToShow - 1 {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.black.opacity(0.4))

                    Text("+\(images.count - maximumImagesToShow)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.primary.opacity(0.05))
                    .frame(height: imageSize.height)

                ProgressView()
                    .scaleEffect(1.4)
            }
        }
    }
}
