//
//  SlideshowView.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMCloseButton

struct SlideshowView: View {
    
    @EnvironmentObject var viewModel: SlideshowImageGridView.ViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView(.init()) {
                TabView(selection: $viewModel.selectedImageIndex) {
                    ForEach(viewModel.images.indices, id: \.self) { index in
                        if let image = viewModel.images[index] {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(index as Int?)
                        } else {
                            ProgressView()
                                .scaleEffect(1.4)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .overlay(
                    CloseButton(action: {
                        withAnimation(.default) {
                            viewModel.closeSlideshow()
                        }
                    })
                    .padding(10)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top),
                    
                    alignment: .topTrailing
                )
            }.ignoresSafeArea()
        }
        .transition(.move(edge: .bottom))
    }
}
