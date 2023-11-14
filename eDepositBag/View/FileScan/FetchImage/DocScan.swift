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

    var body: some View {
        VStack {
            Text(imageTypeList.imageTypes[selectedType!].name)
                .font(.title)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            
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
        
         .fullScreenCover(isPresented: $showImagePicker) {
             ImagePicker(){ images in
                 imageTypeList.imageTypes[selectedType!].images += images
                 presentationMode.wrappedValue.dismiss()
             }
             
         }
         .fullScreenCover(isPresented: $showScanner) {
             ZStack {
                 // background color
                 Color.black.edgesIgnoringSafeArea(.all)
                 VNDocumentCameraViewControllerRepresentable() { images in
                     imageTypeList.imageTypes[selectedType!].images += images
                     presentationMode.wrappedValue.dismiss()
     //                saveImageToSandbox(images: images)
                 }
             }

        }
    }
}


// save images
//    func saveImageToSandbox(images: [UIImage]) {
//        let fileManager = FileManager.default
//        let tempDirectory = fileManager.temporaryDirectory
//
//        // create the image directory
//        let folderName = "image\(selectedType!)"
//        let folderURL = tempDirectory.appendingPathComponent(folderName)
//
//        do {
//            // if the directory already exists, this code does nothing
//            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
//        } catch {
//            print("Error creating directory: \(error)")
//            return
//        }
//
//        for image in images {
//            let fileName = "\(imageTypeList.imageTypes[selectedType!].images.count + 1).jpg"
//            let fileURL = folderURL.appendingPathComponent(fileName)
//
//            // for .png，use image.pngData()
//            if let imageData = image.jpegData(compressionQuality: 1.0) {
//                do {
//                    try imageData.write(to: fileURL)
//                    imageTypeList.imageTypes[selectedType!].images.append(fileURL)
//                    print("Saved image to \(fileURL.path)")
//                } catch {
//                    print("Error saving image: \(error)")
//                }
//            }
//
//        }
//    }



struct DocScan_Previews: PreviewProvider {
    static private var imageTypeList = ImageTypeList()
    static var previews: some View {
        DocScan(selectedType: .constant(0))
            .environmentObject(imageTypeList)
    }
}

