//
//  DocScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//
import SwiftUI

struct DocScan: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedType: Int?
    @EnvironmentObject var imageTypeList: ImageTypeList
    
    @State private var showScanner = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    private let scannerDelegate = DocumentScannerDelegate()

    var body: some View {
        VStack {
            Button(action: {
                self.showScanner = true
            }) {
                VStack {
                    Image(systemName: "doc.text.viewfinder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()

                    Text("Scan Document")
                        .font(.headline)
                }
            }
            .padding(.bottom, 40.0)
            
            Button(action: {
                self.showImagePicker = true
            }) {
                VStack {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()

                    Text("Pick from Photo Library")
                        .font(.headline)
                }
            }
        }
         .sheet(isPresented: $showImagePicker) {
             ImagePicker(selectedImage: $selectedImage)
         }
         .sheet(isPresented: $showScanner) {
            VNDocumentCameraViewControllerRepresentable(scannerDelegate: scannerDelegate) { image in
                // 保存扫描的图片到沙盒
                saveImageToSandbox(image: image)
            }
        }
    }

    func saveImageToSandbox(image: UIImage) {
        // 保存图片到沙盒的逻辑
        // ...
    }
}



struct DocScan_Previews: PreviewProvider {
    static var previews: some View {
        DocScan(selectedType: .constant(2))
    }
}

