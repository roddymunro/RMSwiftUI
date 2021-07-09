//
//  SlideshowImageGridItem.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMSwiftUICore

struct SlideshowImageGridItem: View {
    
    @ObservedObject var viewModel: SlideshowImageGridView.ViewModel
    
    let index: Int
    let imageHeight: CGFloat
    let maximumImagesToShow: Int?
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            if let image = viewModel.images[index] {
                if index < maximumImagesToShow ?? Int.max {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: imageHeight)
                        .cornerRadius(cornerRadius)
                }
                
                if let maximumImagesToShow = maximumImagesToShow, viewModel.images.count > maximumImagesToShow && index == maximumImagesToShow - 1 {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.black.opacity(0.4))
                    
                    Text("+\(viewModel.images.count - maximumImagesToShow)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
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
