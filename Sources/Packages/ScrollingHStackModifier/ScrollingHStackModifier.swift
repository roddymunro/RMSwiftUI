//
//  ScrollingHStackModifier.swift
//  RMSwiftUI
//

import SwiftUI

public struct ScrollingHStackModifier: ViewModifier {
    
    @State private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat
    
    public var items: Int
    public var itemWidth: CGFloat
    public var itemSpacing: CGFloat
    public var snapToLeft: Bool
    
    public init(items: Int, itemWidth: CGFloat, itemSpacing: CGFloat, snapToLeft: Bool=false) {
        self.items = items
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing
        self.snapToLeft = snapToLeft
        
        // Calculate Total Content Width
        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
        
        let screenWidth: CGFloat
        #if !os(macOS)
        screenWidth = UIScreen.main.bounds.width
        #else
        screenWidth = NSScreen.main!.frame.width
        #endif
        
        // Set Initial Offset to first Item
        var initialOffset = (contentWidth/2.0) - (screenWidth/2.0) + ((screenWidth - itemWidth) / 2.0)
        if snapToLeft {
            initialOffset -= (screenWidth / 4.0) + 32
        }
        
        self._scrollOffset = State(initialValue: initialOffset)
        self._dragOffset = State(initialValue: 0)
    }
    
    public func body(content: Content) -> some View {
        content
            .offset(x: scrollOffset + dragOffset, y: 0)
            .gesture(DragGesture()
                .onChanged({ event in
                    dragOffset = event.translation.width
                })
                .onEnded({ event in
                    // Scroll to where user dragged
                    scrollOffset += event.translation.width
                    dragOffset = 0
                    
                    // Now calculate which item to snap to
                    let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
                    
                    let screenWidth: CGFloat
                    #if !os(macOS)
                    screenWidth = UIScreen.main.bounds.width
                    #else
                    screenWidth = NSScreen.main!.frame.width
                    #endif
                    
                    // Center position of current offset
                    var center = scrollOffset + (screenWidth / 2.0) + (contentWidth / 2.0)
                    if snapToLeft {
                        center += (screenWidth / 4.0)
                    }
                    
                    // Calculate which item we are closest to using the defined size
                    var index = (center - (screenWidth / 2.0)) / (itemWidth + itemSpacing)
                    
                    // Should we stay at current index or are we closer to the next item...
                    if index.remainder(dividingBy: 1) > 0.5 {
                        index += 1
                    } else {
                        index = CGFloat(Int(index))
                    }
                    
                    // Protect from scrolling out of bounds
                    index = min(index, CGFloat(items) - 1)
                    index = max(index, 0)
                    
                    // Set final offset (snapping to item)
                    var newOffset = index * itemWidth + (index - 1) * itemSpacing - (contentWidth / 2.0) + (screenWidth / 2.0) - ((screenWidth - itemWidth) / 2.0) + itemSpacing
                    if snapToLeft {
                        newOffset -= (screenWidth / 4.0) + 32
                    }
                    
                    // Animate snapping
                    withAnimation {
                        scrollOffset = newOffset
                    }
                    
                })
            )
    }
}
