//
//  PhotoSelect.swift
//  eDepositBag
//
//  Created by Evan on 11/13/23.
//

import SwiftUI
import PhotosUI // on iOS 14 and above

struct ImagePicker: UIViewControllerRepresentable {
    // hold the selected images
    var completionHandler: (([UIImage]) -> Void)?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0 // 0 for no limit
        configuration.filter = .images // only images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let itemProviders = results.map(\.itemProvider)
            var images: [UIImage] = [] // hold the result
            
            // try to handle all the selected images
            for item in itemProviders {
                if item.canLoadObject(ofClass: UIImage.self) {
                    item.loadObject(ofClass: UIImage.self) { (object, error) in
                        if let image = object as? UIImage {
                            images.append(image)

                            // call the completion handler if this is the last
                            if images.count == itemProviders.count {
                                DispatchQueue.main.async {
                                    self.parent.completionHandler?(images)
                                }
                            }
                            
                        }
                    }
                }
            }
            
            picker.dismiss(animated: true)
            
        }// picker
    }// coordinator
}
