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
    @State private var imageSourcePresented: Bool = false
    
    private let imageHeight: CGFloat
    private let imagesPerRow: Int
    private let maximumImagesToShow: Int?
    private let cornerRadius: CGFloat
    private let didSelectImageSource: ((UIImagePickerController.SourceType)->())?
    private let onDeleteButtonTapped: ((Int) -> ())?
    
    public init(
        images: Binding<[UIImage?]>,
        imageHeight: CGFloat,
        imagesPerRow: Int,
        maximumImagesToShow: Int?=nil,
        cornerRadius: CGFloat = 12,
        didSelectImageSource: ((UIImagePickerController.SourceType) -> ())?=nil,
        onDeleteButtonTapped: ((Int) -> ())?=nil
    ) {
        self._images = images
        self.imageHeight = imageHeight
        self.imagesPerRow = imagesPerRow
        self.maximumImagesToShow = maximumImagesToShow
        self.cornerRadius = cornerRadius
        self.didSelectImageSource = didSelectImageSource
        self.onDeleteButtonTapped = onDeleteButtonTapped
        UIScrollView.appearance().bounces = false
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: imagesPerRow), alignment: .leading, spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    if index < images.count {
                        ZStack(alignment: .topTrailing) {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    openImage(at: index)
                                }
                            }) {
                                SlideshowImageGridItem(images: $images, index: index, cellHeight: imageHeight, maximumImagesToShow: maximumImagesToShow, cornerRadius: cornerRadius)
                            }
                            
                            if let maximumImagesToShow = maximumImagesToShow, images.count > maximumImagesToShow && index == maximumImagesToShow - 1 {
                                // show no button
                            } else if let onDeleteButtonTapped = onDeleteButtonTapped {
                                Button(action: { onDeleteButtonTapped(index) }) {
                                    Image(systemName: "trash")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.black)
                                        .clipShape(Circle())
                                }
                                .padding(6)
                            }
                        }
                    }
                }
                if let didSelectImageSource = didSelectImageSource {
                    Button(action: { imageSourcePresented = true }) {
                        addButtonLabel
                    }
                    .confirmationDialog("Image Source", isPresented: $imageSourcePresented, titleVisibility: .visible) {
                        Button("Camera", action: { didSelectImageSource(.camera) })
                        Button("Photo Library", action: { didSelectImageSource(.photoLibrary) })
                        Button("Cancel", role: .cancel, action: { imageSourcePresented = false })
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
                .frame(height: imageHeight)
            
            Image(systemName: "plus")
                .foregroundColor(Color.primary.opacity(0.6))
                .font(.title.weight(.semibold))
        }
    }
    
    private func openImage(at idx: Int) {
        self.selectedImageIndex = idx
        self.slideshowOpened = true
    }
}
