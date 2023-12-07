//
//  BarcodeScan.swift
//  eDepositBag
//
//  Created by Evan on 11/2/23.
//
//  Methods learned from https://gist.github.com/WunDaii/497d44da694d4a013d378df5e47977be

import SwiftUI
import AVFoundation

//MARK: protocol for ScannerViewController delegate
protocol ScannerViewControllerDelegate: AnyObject {
    // callback method when a barcode is found
    func didFind(barcode: String)
    // callback method when scanning fails
    func didFail(reason: String)
}


//MARK: adapts a UIKit UIViewController to SwiftUI
struct BarcodeScan: UIViewControllerRepresentable {
    @Binding var isPresentingScanner: Bool
    @Binding var scannedCode: String?
    @Binding var isScanFail: Bool
    
    // MARK: - UIViewControllerRepresentable protocol
    
    //  called only once when the view shows up. Create the UIViewController instance.
    func makeUIViewController(context: Context) -> UIViewController {
        let scannerViewController = ScannerViewController()
        // receive scanning results
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    // called when the view updates. No need to do anything
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    // create a coordinator object, which helps handle events passed from the ScannerViewController
    func makeCoordinator() -> Coordinator {
        return Coordinator(scannerView: self)
    }
     
    class Coordinator: ScannerViewControllerDelegate {
        var scannerView: BarcodeScan // self
        
        init(scannerView: BarcodeScan) {
            self.scannerView = scannerView
        }
        
        // called when finding barcode
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
            scannerView.isPresentingScanner = false
            scannerView.isScanFail = false
        }
        
        // called when failed
        func didFail(reason: String) {
            scannerView.scannedCode = nil
            scannerView.isPresentingScanner = false
            scannerView.isScanFail = true
        }
    }
}

// responsible for barcode scanning functionality
class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // return the scanning results
    var delegate: ScannerViewControllerDelegate? //Coordinator
    // manage input (camera) and output (scanning results)
    var captureSession: AVCaptureSession!
    // display the real-time video stream
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    // called after the view has finished loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        // set the camera
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video)
            else { return }
        let videoInput: AVCaptureDeviceInput
        
        // video input
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.didFail(reason: "Unable to obtain video input")
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.didFail(reason: "Unable to add video input")
            return
        }
        
        // create and configure barcode metadata output
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            // set output delegate (self.metadataOutput), callbacks should be received on the main queue
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            // type of the barcodes
            metadataOutput.metadataObjectTypes = [.upce, .code39, .code39Mod43, .ean13, .ean8, .code93, .code128, .codabar, .itf14, .interleaved2of5]
        } else {
            delegate?.didFail(reason: "Unable to add metadata output")
            return
        }
        
        // initialize the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // start session
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // AVCaptureMetadataOutputObjectsDelegate protocl. called when finding any barcode
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // stop
        captureSession.stopRunning()
        
        // check the result
        if let metadataObject = metadataObjects.first {
            // convert data to string
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue
                else { return }
            // trigger device vibration to provide physical feedback
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.didFind(barcode: stringValue)
        }
    }

    // only supporting portrait mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    // called when the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!captureSession.isRunning) {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }

    // called when the view is about to disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession.isRunning) {
            captureSession.stopRunning()
        }
    }

    // disable automatic rotation
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

