//
//  CameraScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/13/23.
//

import SwiftUI
import VisionKit

struct VNDocumentCameraViewControllerRepresentable: UIViewControllerRepresentable {
    
    // return and handle the result
    var completionHandler: (([UIImage]) -> Void)?

    // coordinator to manage delegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // create the UIViewController
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator // Set the coordinator as delegate
        return viewController
    }

    // not used
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) { }

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: VNDocumentCameraViewControllerRepresentable

        init(_ parent: VNDocumentCameraViewControllerRepresentable) {
            self.parent = parent
        }

        // handle the result of the scanning
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var images: [UIImage] = []
            for pageIndex in 0..<scan.pageCount {
                let image = scan.imageOfPage(at: pageIndex)
                images.append(image)
            }

            // return the result
            parent.completionHandler?(images)
            controller.dismiss(animated: true)
        }
    }
}
