//
//  BarcodeScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI
import AVFoundation

// Protocol for ScannerViewController delegate
protocol ScannerViewControllerDelegate: AnyObject {
    // Callback method when a barcode is found
    func didFind(barcode: String)
    // Callback method when scanning fails
    func didFail(reason: String)
}


// BarcodeScan adapts a UIKit UIViewController to SwiftUI
struct BarcodeScan: UIViewControllerRepresentable {
    @Binding var isPresentingScanner: Bool
    @Binding var scannedCode: String?
    @Binding var isScanFail: Bool
    
    // MARK: - UIViewControllerRepresentable protocol
    
    //  Called only once when the view shows up. Create the UIViewController instance.
    func makeUIViewController(context: Context) -> UIViewController {
        let scannerViewController = ScannerViewController()
        // set the delegate to receive scanning results
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    // Called when the view updates. No need to do anything
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    // Create a coordinator object, which serves as a bridge between SwiftUI and UIKit.
    func makeCoordinator() -> Coordinator {
        return Coordinator(scannerView: self)
    }
     
    // Helps handle events passed from the ScannerViewController
    class Coordinator: ScannerViewControllerDelegate {
        var scannerView: BarcodeScan // self
        
        init(scannerView: BarcodeScan) {
            self.scannerView = scannerView
        }
        
        // Called when finding barcode
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
            scannerView.isPresentingScanner = false
            scannerView.isScanFail = false
        }
        
        // Called when failed
        func didFail(reason: String) {
            scannerView.scannedCode = nil
            scannerView.isPresentingScanner = false
            scannerView.isScanFail = true
        }
    }
}

// Responsible for barcode scanning functionality
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // Used to return the scanning results to the BarcodeScan view
    var delegate: ScannerViewControllerDelegate? //Coordinator
    // Used to manage input (camera) and output (scanning results)
    var captureSession: AVCaptureSession!
    // Display the real-time video stream captured from the camera.
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    // Called after the view has finished loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        // Set the camera
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video)
            else { return }
        let videoInput: AVCaptureDeviceInput
        
        // Try video input
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.didFail(reason: "Unable to obtain video input")
            return
        }
        
        // Add video to the session
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.didFail(reason: "Unable to add video input")
            return
        }
        
        // Create and configure barcode metadata output
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            // Set output delegate(self.metadataOutput)
            // Callbacks should be received on the main queue
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            // Type of the metadata (type of the barcodes)
            metadataOutput.metadataObjectTypes = [.upce, .code39, .code39Mod43, .ean13, .ean8, .code93, .code128, .codabar, .itf14, .interleaved2of5]
        } else {
            delegate?.didFail(reason: "Unable to add metadata output")
            return
        }
        
        // Initialize the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        // Add the preview layer to the view's layer
        view.layer.addSublayer(previewLayer)
        
        // Start session
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // AVCaptureMetadataOutputObjectsDelegate protocl. Called when finding any barcode
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Stop capturing
        captureSession.stopRunning()
        
        // Check if there's any object
        if let metadataObject = metadataObjects.first {
            // Convert data type to string
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue
                else { return }
            // Trigger device vibration to provide physical feedback
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.didFind(barcode: stringValue)
        }
    }

    // Only supporting portrait mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // Called when the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!captureSession.isRunning) {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }

    // Called when the view is about to disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession.isRunning) {
            captureSession.stopRunning()
        }
    }

    // Disable automatic rotation
    override var shouldAutorotate: Bool {
        return false
    }
}

struct BarcodeScan_Previews: PreviewProvider {
    @State static var isPresentingScanner = false
    @State static var scannedCode: String?
    @State static var isScanFail = false
    
    static var previews: some View {
        BarcodeScan(isPresentingScanner: $isPresentingScanner, scannedCode: $scannedCode, isScanFail: $isScanFail)
    }
}

