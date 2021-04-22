//
//  OnboardingView.swift
//  RMSwiftUI
//

import SwiftUI
import RMSwiftUICore

public struct OnboardingPageContent {
    var image: String
    var heading: String
    var text: String
    
    public init(image: String, heading: String, text: String) {
        self.image = image
        self.heading = heading
        self.text = text
    }
}

public struct OnboardingView: View {
    
    var pages: [OnboardingPageContent]
    var doneFunction: () -> ()
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    public init(pages: [OnboardingPageContent], doneFunction: @escaping () -> ()) {
        self.pages = pages
        self.doneFunction = doneFunction
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .center) {
                ForEach(0..<pages.count) { i in
                    OnboardingPageView(page: pages[i])
                        .offset(x: CGFloat(i) * distance)
                        .offset(x: slideGesture.width - CGFloat(curSlideIndex) * distance)
                        .animation(.spring())
                        .gesture(DragGesture().onChanged{ value in
                            slideGesture = value.translation
                        }
                        .onEnded{ value in
                            if slideGesture.width < -50 {
                                if curSlideIndex < pages.count - 1 {
                                    withAnimation {
                                        curSlideIndex += 1
                                    }
                                }
                            }
                            if slideGesture.width > 50 {
                                if curSlideIndex > 0 {
                                    withAnimation {
                                        curSlideIndex -= 1
                                    }
                                }
                            }
                            slideGesture = .zero
                        })
                }
            }
            
            Button(action: nextButtonTapped, label: { Text((curSlideIndex == pages.count - 1) ? "Done" : "Next") })
                .buttonStyle(PrimaryButtonStyle())
        
            StepProgressView(currentIndex: $curSlideIndex, max: pages.count)
        }
        .padding(20)
    }
    
    func nextButtonTapped() {
        if curSlideIndex == pages.count - 1 {
            doneFunction()
            return
        }
        
        if curSlideIndex < pages.count - 1 {
            withAnimation {
                curSlideIndex += 1
            }
        }
    }
}

struct OnboardingPageView: View {
    var page: OnboardingPageContent
    
    var body: some View {
        VStack {
            Image(page.image)
                .resizable()
                .scaledToFit()
                .padding(.top, 24)
                .frame(maxWidth: 400)
            
            Spacer()
            
            VStack(spacing: 16) {
                Text(page.heading)
                    .font(Font.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                Text(page.text)
                    .font(Font.headline.weight(.medium))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.6)
            }
        }
        .padding()
    }
}
