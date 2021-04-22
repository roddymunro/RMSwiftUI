//
//  ImagePicker.swift
//  RMSwiftUI
//

import SwiftUI

#if !os(macOS)
public struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding private var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    private var onImageSelection: (() -> ())?
    
    public init(image: Binding<UIImage?>, sourceType: UIImagePickerController.SourceType, onImageSelection: (() -> ())?=nil) {
        self._image = image
        self.sourceType = sourceType
        self.onImageSelection = onImageSelection
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        private let parent: ImagePicker

        public init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            if let onImageSelection = parent.onImageSelection {
                onImageSelection()
            } else {
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
#endif
