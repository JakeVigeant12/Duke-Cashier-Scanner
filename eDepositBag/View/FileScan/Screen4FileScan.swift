//
//  Screen5FileScan.swift
//  eDepositBag
//
//  Created by Evan on 11/2/23.
//

import SwiftUI

struct Screen4FileScan: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var imageTypeList: ImageTypeList
    @EnvironmentObject var tabModel: TabModel
    
    @State private var startScan = false
    @State private var selectedType: Int?

    @State private var showScanner: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showPickerSelection: Bool = false
    
    var body: some View {
        VStack {
            // image list, sorted by type
            ScrollView {// using scrollview instead of list for more customized functions
                VStack(spacing: 25){
                    ForEach(imageTypeList.imageTypes.indices, id: \.self) { index in
                        let imageType = imageTypeList.imageTypes[index]
                        VStack{
                            // Section header
                            HStack {
                                Text(imageType.name)
                                    .font(.body)
                                    .textCase(nil)
                                Spacer()
                                Button(action: {
                                    self.selectedType = index
                                    self.showPickerSelection = true
                                }) {
                                    Image(systemName: "plus.circle")
                                        .padding()
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                }
                                // choose a way to upload images
                                .actionSheet(isPresented: $showPickerSelection) {
                                    ActionSheet(title: Text("Choose Image Source"), buttons: [
                                        .default(Text("Camera")) {
                                            self.showScanner = true
                                        },
                                        .default(Text("Photo Library")) {
                                            self.showImagePicker = true
                                        },
                                        .cancel()
                                    ])
                                }
                                // select from photo library
                                .fullScreenCover(isPresented: $showImagePicker) {
                                    ImagePicker(){ images in
                                        imageTypeList.imageTypes[selectedType!].images += images
                                    }
                                    
                                }
                                // camera scan
                                .fullScreenCover(isPresented: $showScanner) {
                                    ZStack {
                                        // background color
                                        Color.black.edgesIgnoringSafeArea(.all)
                                        VNDocumentCameraViewControllerRepresentable() { images in
                                            imageTypeList.imageTypes[selectedType!].images += images
                                        }
                                    }
                               }
                                
                            }
                            // List row content
                            ListRow(imageType: imageTypeList.imageTypes[index])
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal,30)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        
                        .background {
                            TransparentBlur(removeAllFilters: false)
                                .blur(radius: 9, opaque: true)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .shadow(color: .black.opacity(0.25), radius: 10)
                    }
                    
                    // "Done" button
                    NavigationLink(destination:
                                    Screen5Submit()
                                        .environmentObject(bag)
                                        .environmentObject(imageTypeList)
                                        .environmentObject(tabModel)
                    ) {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.blue)
                    .opacity(0.8)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.2), radius: 10)
                
                }
                .foregroundStyle(.white)
                .padding(.horizontal,25)
                .padding(.top, 25)
                .padding(.bottom, 20)
                
            }
        }
        
        .background {
            Image("bg1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.1))
            TransparentBlur(removeAllFilters: false)
        }
        
        .navigationTitle("Scan Documents")
        .navigationBarTitleDisplayMode(.large)

    }
}

struct Screen4FileScan_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var tableModel = TabModel()
    static var previews: some View {
        Screen4FileScan()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
            .environmentObject(tableModel)
    }
}
