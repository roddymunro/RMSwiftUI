//
//  SlideshowImageGridItem.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI

struct SlideshowImageGridItem: View {
    
    @EnvironmentObject var viewModel: SlideshowImageGridView.ViewModel
    
    let index: Int
    let imageHeight: CGFloat
    let maximumImagesToShow: Int?
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            if index < maximumImagesToShow ?? Int.max {
                viewModel.images[index]
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
        }
    }
}
