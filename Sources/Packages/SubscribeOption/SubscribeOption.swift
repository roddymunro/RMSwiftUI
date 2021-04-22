//
//  SubscribeOption.swift
//  RMSwiftUI
//

import SwiftUI
import RMSwiftUICore

public struct SubscribeOption: View {
    
    private var price: Double
    private var priceString: String?
    private var months: Double
    @Binding private var checked: Bool
    
    public init(price: NSNumber?, priceString: String?, months: Double=0, checked: Binding<Bool>) {
        self.price = price?.doubleValue ?? 0
        self.priceString = priceString
        self.months = months
        self._checked = checked
    }
    
    private var isSub: Bool {
        Int(months) > 0
    }
    
    private var pricePerMonthString: String {
        if isSub {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currencyAccounting
            formatter.currencySymbol = Locale.current.currencySymbol ?? "$"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            
            let pricePerMonth = formatter.string(from: NSNumber(value: (price / months)))
            
            return "\(pricePerMonth!) / month billed every \(Int(months)) months"
        } else {
            return "\(priceString ?? "") billed once"
        }
    }
    
    public var body: some View {
        Button(action: { checked.toggle() }) {
            HStack(alignment: .center) {
                Toggle("Complete", isOn: $checked)
                    .padding(4)
                    .padding(.vertical, 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(priceString ?? "") / \(isSub ? "\(Int(months)) Months" : "Lifetime")")
                        .font(Font.headline.weight(.semibold))
                        
                    Text(pricePerMonthString)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(checked ? .accentColor : Color(.lightGray), lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .toggleStyle(CircleToggleStyle())
    }
}
