//
//  SlideshowView.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMCloseButton

struct SlideshowView: View {
    
    @Binding var images: [UIImage?]
    @Binding var selectedImageIndex: Int?
    @Binding var slideshowOpened: Bool
    
    init(images: Binding<[UIImage?]>, selectedImageIndex: Binding<Int?>, slideshowOpened: Binding<Bool>) {
        self._images = images
        self._selectedImageIndex = selectedImageIndex
        self._slideshowOpened = slideshowOpened
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.accentColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView(.init()) {
                TabView(selection: $selectedImageIndex) {
                    ForEach(images.indices, id: \.self) { index in
                        if let image = images[index] {
                            Image(uiImage: image)
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
                            closeSlideshow()
                        }
                    })
                    .padding(12),
                    
                    alignment: .topTrailing
                )
            }.ignoresSafeArea()
        }
        .transition(.move(edge: .bottom))
    }
    
    private func closeSlideshow() {
        self.slideshowOpened = false
        self.selectedImageIndex = nil
    }
}
