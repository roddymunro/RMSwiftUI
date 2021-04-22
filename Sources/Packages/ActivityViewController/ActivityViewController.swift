//
//  ActivityViewController.swift
//  RMSwiftUI
//

#if !os(macOS)
import UIKit
import SwiftUI

public struct ActivityViewController: UIViewControllerRepresentable {

    private var activityItems: [Any]
    private var applicationActivities: [UIActivity]? = nil
    
    public init(activityItems: [Any], applicationActivities: [UIActivity]?=nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
#endif
