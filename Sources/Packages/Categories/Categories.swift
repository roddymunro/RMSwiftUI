//
//  File.swift
//  
//
//  Created by Roddy Munro on 2021-05-23.
//

import SwiftUI
import RMSwiftUICore

public struct Categories: View {
    
    private var categories: [Option]
    @Binding private var selection: Option?
    
    public init(categories: [Option], selection: Binding<Option?>) {
        self.categories = categories
        self._selection = selection
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(categories) { category in
                    Button(action: {
                        self.selection = category
                    }, label: {
                        category.display
                            .foregroundColor(Color(.secondaryLabel))
                            .multilineTextAlignment(.center)
                            .font(Font.callout.weight(.medium))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 12)
                            .background(selection == category ? Color.accentColor.opacity(0.3) : Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    })
                }
            }
        }
    }
    
    public struct Option: Identifiable, Equatable {
        public var id = UUID()
        public var value: String
        public var display: Text
        
        public init(value: String, display: Text) {
            self.value = value
            self.display = display
        }
    }
}

struct Categories_Preview: PreviewProvider {

    static let categories: [Categories.Option] = [
        .init(value: "Favourites", display: Text(Image(systemName: "heart"))),
        .init(value: "Recommended for You", display: Text("Recommended for You")),
        .init(value: "Popular", display: Text("Popular"))
    ]

    static var previews: some View {
        Categories(categories: categories, selection: .constant(categories[1]))
    }
}
