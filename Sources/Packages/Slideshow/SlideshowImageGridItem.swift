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
    let imageHeight: CGFloat
    let maximumImagesToShow: Int?
    let cornerRadius: CGFloat
    let onDeleteButtonTapped: ((Int) -> ())?
    
    var body: some View {
        ZStack {
            if let image = images[index] {
                if index < maximumImagesToShow ?? Int.max {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: imageHeight)
                        .cornerRadius(cornerRadius)
                }
                
                if let maximumImagesToShow = maximumImagesToShow, images.count > maximumImagesToShow && index == maximumImagesToShow - 1 {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.black.opacity(0.4))
                    
                    Text("+\(images.count - maximumImagesToShow)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                } else if let onDeleteButtonTapped = onDeleteButtonTapped {
                    Button(action: { onDeleteButtonTapped(index) }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.background)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                    .padding(8)
                }
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.primary.opacity(0.05))
                    .frame(height: imageHeight)
                
                ProgressView()
                    .scaleEffect(1.4)
            }
        }
    }
}
