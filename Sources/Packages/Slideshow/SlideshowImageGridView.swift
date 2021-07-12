//
//  SlideshowImageGridView.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMSwiftUICore

public struct SlideshowImageGridView: View {
    
    @Binding private var images: [UIImage?]
    @State private var selectedImageIndex: Int?
    @State private var slideshowOpened: Bool = false
    
    private let imageSize: CGSize
    private let maximumImagesToShow: Int?
    private let cornerRadius: CGFloat
    private let onAddButtonTapped: (() -> ())?
    
    public init(images: Binding<[UIImage?]>, imageSize: CGSize, maximumImagesToShow: Int?=nil, cornerRadius: CGFloat = 12, onAddButtonTapped: (() -> ())?=nil) {
        self._images = images
        self.imageSize = imageSize
        self.maximumImagesToShow = maximumImagesToShow
        self.cornerRadius = cornerRadius
        self.onAddButtonTapped = onAddButtonTapped
        UIScrollView.appearance().bounces = false
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: imageSize.width), spacing: 16)], alignment: .leading, spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            openImage(at: index)
                        }
                    }) {
                        SlideshowImageGridItem(images: $images, index: index, imageHeight: imageSize.height, maximumImagesToShow: maximumImagesToShow, cornerRadius: cornerRadius)
                    }
                }
                if let onAddButtonTapped = onAddButtonTapped {
                    Button(action: onAddButtonTapped) {
                        addButtonLabel
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .sheet(isPresented: $slideshowOpened, onDismiss: { selectedImageIndex = nil }) {
            SlideshowView(images: $images, selectedImageIndex: $selectedImageIndex, slideshowOpened: $slideshowOpened)
        }
    }
    
    private var addButtonLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.primary.opacity(0.05))
                .frame(height: imageSize.height)
            
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundColor(Color.primary.opacity(0.6))
        }
    }
    
    private func openImage(at idx: Int) {
        self.selectedImageIndex = idx
        self.slideshowOpened = true
    }
}
