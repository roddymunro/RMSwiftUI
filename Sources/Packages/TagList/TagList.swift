//
//  TagList.swift
//  RMSwiftUI
//

import SwiftUI

public struct TagList: View {

    @Binding var allTags: Set<String>
    @Binding var selectedTags: Set<String>
    private let embedInScrollView: Bool

    private var orderedTags: [String] { allTags.sorted() }
    
    public init(allTags: Binding<Set<String>>, selectedTags: Binding<Set<String>>, embedInScrollView: Bool=true) {
        self._allTags = allTags
        self._selectedTags = selectedTags
        self.embedInScrollView = embedInScrollView
    }

    private func rowCounts(_ geometry: GeometryProxy) -> [Int] {
        TagList.rowCounts(tags: orderedTags, padding: 26, parentWidth: geometry.size.width)
    }

    private func tag(rowCounts: [Int], rowIndex: Int, itemIndex: Int) -> String {
        let sumOfPreviousRows = rowCounts.enumerated().reduce(0) { total, next in
            if next.offset < rowIndex {
                return total + next.element
            } else {
                return total
            }
        }
        let orderedTagsIndex = sumOfPreviousRows + itemIndex
        guard orderedTags.count > orderedTagsIndex else { return "[Unknown]" }
        return orderedTags[orderedTagsIndex]
    }

    public var body: some View {
        GeometryReader { geometry in
            if embedInScrollView {
                ScrollView {
                    content(geo: geometry)
                }
            } else {
                content(geo: geometry)
            }
        }
    }
    
    private func content(geo: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            ForEach(rowCounts(geo).indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(0 ..< rowCounts(geo)[rowIndex], id: \.self) { itemIndex in
                        TagButton(title: tag(rowCounts: rowCounts(geo), rowIndex: rowIndex, itemIndex: itemIndex), selectedTags: $selectedTags)
                    }
                    Spacer()
                }.padding(.vertical, 4)
            }
            Spacer()
        }
    }
}

extension String {
    public func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension TagList {
    public static func rowCounts(tags: [String], padding: CGFloat, parentWidth: CGFloat) -> [Int] {
        let tagWidths = tags.map{$0.widthOfString(usingFont: UIFont.preferredFont(forTextStyle: .headline))}

        var currentLineTotal: CGFloat = 0
        var currentRowCount: Int = 0
        var result: [Int] = []

        for tagWidth in tagWidths {
            let effectiveWidth = tagWidth + (2 * padding)
            if currentLineTotal + effectiveWidth <= parentWidth {
                currentLineTotal += effectiveWidth
                currentRowCount += 1
                guard result.count != 0 else { result.append(1); continue }
                result[result.count - 1] = currentRowCount
            } else {
                currentLineTotal = effectiveWidth
                currentRowCount = 1
                result.append(1)
            }
        }

        return result
    }
}

public struct TagButton: View {

    let title: String
    @Binding var selectedTags: Set<String>

    private let vPad: CGFloat = 13
    private let hPad: CGFloat = 22
    private let radius: CGFloat = 24
    
    public init(title: String, selectedTags: Binding<Set<String>>) {
        self.title = title
        self._selectedTags = selectedTags
    }

    public var body: some View {
        Button(action: {
            if selectedTags.contains(title) {
                selectedTags.remove(title)
            } else {
                selectedTags.insert(title)
            }
        }) {
            if selectedTags.contains(title) {
                HStack {
                    Text(title)
                        .font(.headline)
                }
                .padding(.vertical, vPad)
                .padding(.horizontal, hPad)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(radius)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(UIColor.systemBackground), lineWidth: 1)
                )

            } else {
                HStack {
                    Text(title)
                        .font(Font.headline.weight(.light))
                }
                .padding(.vertical, vPad)
                .padding(.horizontal, hPad)
                .foregroundColor(.primary)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}
