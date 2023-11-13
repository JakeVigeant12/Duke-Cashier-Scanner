//
//  CameraScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/13/23.
//

import SwiftUI
import VisionKit

// handle the result of scanning
class DocumentScannerDelegate: NSObject, VNDocumentCameraViewControllerDelegate {
    var completionHandler: ((UIImage) -> Void)?

    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        // handle result
        if scan.pageCount > 0 {
            let image = scan.imageOfPage(at: 0) // first one
            completionHandler?(image)
        }
        controller.dismiss(animated: true)
    }
}

struct VNDocumentCameraViewControllerRepresentable: UIViewControllerRepresentable {
    var scannerDelegate: DocumentScannerDelegate
    var completionHandler: ((UIImage) -> Void)?

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = scannerDelegate
        scannerDelegate.completionHandler = completionHandler
        return viewController
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) { }
}
