//
//  SlideshowView.swift
//
//  Created by Roddy Munro on 06/06/2021.
//

import SwiftUI
import RMCloseButton

struct SlideshowView: View {
    
    @EnvironmentObject var viewModel: SlideshowImageGridView.ViewModel
    @GestureState var draggingOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.background
                .opacity(viewModel.bgOpacity)
                .ignoresSafeArea()
            
            ScrollView(.init()) {
                TabView(selection: $viewModel.selectedImageIndex) {
                    ForEach(viewModel.images.indices, id: \.self) { index in
                        if let image = viewModel.images[index] {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .tag(index as Int?)
                                .scaleEffect(viewModel.selectedImageIndex == index ? (viewModel.imageScale > 1 ? viewModel.imageScale : 1) : 1)
                                .offset(y: viewModel.imageViewerOffset.height)
                                .gesture(
                                    MagnificationGesture().onChanged { value in
                                        viewModel.imageScale = value
                                    }.onEnded { _ in
                                        withAnimation(.spring()) {
                                            viewModel.imageScale = 1
                                        }
                                    }
                                    .simultaneously(with: TapGesture(count: 2).onEnded {
                                        withAnimation {
                                            viewModel.imageScale = viewModel.imageScale > 1 ? 1 : 4
                                        }
                                    })
                                )
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
                            viewModel.selectedImageIndex = nil
                        }
                    })
                    .padding(10)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .opacity(viewModel.bgOpacity),
                    
                    alignment: .topTrailing
                )
            }.ignoresSafeArea()
        }
        .gesture(DragGesture().updating($draggingOffset) { value, outValue, _ in
            outValue = value.translation
            viewModel.onChange(value: draggingOffset)
        }
        .onEnded(viewModel.onEnd))
        .transition(.move(edge: .bottom))
    }
}
