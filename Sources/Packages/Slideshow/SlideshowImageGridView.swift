//
//  SlideshowImageGridView.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMSwiftUICore

public struct SlideshowImageGridView: View {
    
    @StateObject var viewModel: ViewModel
    
    private let imageSize: CGSize
    private let numberOfImagesToShow: Int
    private let cornerRadius: CGFloat
    
    public init(images: [Image], imageSize: CGSize, numberOfImagesToShow: Int, cornerRadius: CGFloat = 12) {
        self._viewModel = StateObject(wrappedValue: .init(images: images))
        self.imageSize = imageSize
        self.numberOfImagesToShow = numberOfImagesToShow
        self.cornerRadius = cornerRadius
        UIScrollView.appearance().bounces = false
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: imageSize.width), spacing: 16)], alignment: .leading, spacing: 8) {
                ForEach(viewModel.images.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            viewModel.selectedImageIndex = index
                        }
                    }) {
                        SlideshowImageGridItem(index: index, imageHeight: imageSize.height, numberOfImagesToShow: numberOfImagesToShow, cornerRadius: cornerRadius)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(
            ZStack {
                if viewModel.selectedImageIndex != nil {
                    SlideshowView()
                }
            }
        )
        .environmentObject(viewModel)
    }
}

extension SlideshowImageGridView {
    class ViewModel: ObservableObject {
        @Published private(set) var images: [Image] = []
        @Published public var selectedImageIndex: Int?
        @Published var imageViewerOffset: CGSize = .zero
        @Published var bgOpacity: Double = 1
        @Published var imageScale: CGFloat = 1
        
        init(images: [Image]) {
            self.images = images
        }
        
        public func onChange(value: CGSize) {
            imageViewerOffset = value
            
            let halfHeight = UIScreen.main.bounds.height / 2
            let progress = imageViewerOffset.height / halfHeight
            
            withAnimation(.default) {
                bgOpacity = Double(1 - (progress < 0 ? -progress : progress))
            }
        }
        
        public func onEnd(value: DragGesture.Value) {
            withAnimation(.easeInOut) {
                var translation = value.translation.height
                
                if translation < 0 {
                    translation = -translation
                }
                
                if translation >= 250 {
                    selectedImageIndex = nil
                }
                
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}

struct Slideshow_Previews: PreviewProvider {
    
    static var previews: some View {
        SlideshowImageGridView(images: [
            "image1", "image2", "image3", "image4", "image5", "image6"
        ].map { Image($0, bundle: .module) }, imageSize: .init(width: 140, height: 120), numberOfImagesToShow: 4)
    }
}
