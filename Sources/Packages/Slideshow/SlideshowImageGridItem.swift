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
    let numberOfImagesToShow: Int
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            if index < numberOfImagesToShow {
                viewModel.images[index]
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: imageHeight)
                    .cornerRadius(cornerRadius)
            }
            
            if viewModel.images.count > numberOfImagesToShow && index == numberOfImagesToShow - 1 {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.black.opacity(0.4))
                
                Text("+\(viewModel.images.count - numberOfImagesToShow)")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
        }
    }
}
