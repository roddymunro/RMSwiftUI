//
//  FormTextField.swift
//  RMSwiftUI
//

import SwiftUI

public struct FormField: View {
    private var label: String
    @Binding private var binding: String
    private var placeholder: String?
    
    public init(label: String, binding: Binding<String>, placeholder: String?=nil) {
        self.label = label
        self._binding = binding
    }
    
    public var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
            Spacer()
            TextField(label, text: $binding)
                .multilineTextAlignment(.trailing)
        }
        .accessibility(identifier: "\(label.filter { !$0.isWhitespace })Label")
    }
}

public struct SecureFormField: View {
    private var label: String
    @Binding private var binding: String
    
    public init(label: String, binding: Binding<String>) {
        self.label = label
        self._binding = binding
    }
    
    public var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
            Spacer()
            SecureField(label, text: $binding)
                .multilineTextAlignment(.trailing)
        }
        .accessibility(identifier: "\(label.filter { !$0.isWhitespace })Label")
    }
}

public struct CurrencyFormField: View {
    var label: String
    @Binding var binding: String
    var placeholder: String?
    
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = Locale.current.currencySymbol ?? "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter
    }()
    
    public init(binding: Binding<String>, label: String, placeholder: String?=nil) {
        self._binding = binding
        self.label = label
        self.placeholder = placeholder
    }
    
    public var body: some View {
        let textBinding = Binding<String>(get: {
            self.binding
        }, set: {
            self.binding = formatCurrency(for: $0)
        })
        
        return HStack {
            Text(label)
                .fontWeight(.medium)
            Spacer()
            TextField(placeholder ?? label, text: textBinding)
                .multilineTextAlignment(.trailing)
                .keyboardType(UIKeyboardType.decimalPad)
        }
    }
    
    private func formatCurrency(for valueStr: String) -> String {
        var number: NSNumber!
        var amountWithPrefix = valueStr

        // remove from String: "$", ".", ","
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, valueStr.count), withTemplate: "")

            let double = (amountWithPrefix as NSString).doubleValue
            number = NSNumber(value: (double / 100))

            // if first number is 0 or all numbers were deleted
            guard number != 0 as NSNumber else {
                return "$0"
            }

            return Self.currencyFormatter.string(from: number)!
        } catch {
            return "$0"
        }
    }
}

public struct NumberFormField: View {
    var label: String
    @Binding var binding: String
    var placeholder: String?
    var units: String?
    var keyboardType: UIKeyboardType = .decimalPad
    
    public init(binding: Binding<String>, label: String, placeholder: String?=nil, units: String?=nil, keyboardType: UIKeyboardType = .decimalPad) {
        self._binding = binding
        self.label = label
        self.placeholder = placeholder
        self.units = units
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
            Spacer()
            TextField(
                placeholder ?? label,
                text: $binding
            )
                .multilineTextAlignment(.trailing)
                .keyboardType(keyboardType)
            Text(units ?? "")
        }
    }
}
