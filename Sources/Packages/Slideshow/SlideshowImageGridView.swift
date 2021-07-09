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
    private let maximumImagesToShow: Int?
    private let cornerRadius: CGFloat
    
    public init(images: [Image?], imageSize: CGSize, maximumImagesToShow: Int?=nil, cornerRadius: CGFloat = 12) {
        self._viewModel = StateObject(wrappedValue: .init(images: images))
        self.imageSize = imageSize
        self.maximumImagesToShow = maximumImagesToShow
        self.cornerRadius = cornerRadius
        UIScrollView.appearance().bounces = false
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: imageSize.width), spacing: 16)], alignment: .leading, spacing: 8) {
                ForEach(viewModel.images.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            viewModel.openImage(at: index)
                        }
                    }) {
                        SlideshowImageGridItem(viewModel: viewModel, index: index, imageHeight: imageSize.height, maximumImagesToShow: maximumImagesToShow, cornerRadius: cornerRadius)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .sheet(isPresented: $viewModel.slideshowOpened, onDismiss: viewModel.closeSlideshow) {
            SlideshowView(viewModel: viewModel)
        }
    }
}

extension SlideshowImageGridView {
    class ViewModel: ObservableObject {
        @Published var images: [Image?] = []
        @Published public var selectedImageIndex: Int?
        @Published public var slideshowOpened: Bool = false
        
        init(images: [Image?]) {
            self.images = images
        }
        
        public func openImage(at idx: Int) {
            self.selectedImageIndex = idx
            self.slideshowOpened = true
        }
        
        public func closeSlideshow() {
            self.slideshowOpened = false
            self.selectedImageIndex = nil
        }
    }
}

struct Slideshow_Previews: PreviewProvider {
    
    static let images = [
        "image1", "image2", "image3", "image4", "image5", "image6"
    ].map { Image($0, bundle: .module) }
    
    static var previews: some View {
        SlideshowImageGridView(images: images, imageSize: .init(width: 140, height: 120), maximumImagesToShow: 4)
        SlideshowImageGridView(images: images, imageSize: .init(width: 140, height: 120))
    }
}
