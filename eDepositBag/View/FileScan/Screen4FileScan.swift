//
//  Screen5FileScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen4FileScan: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var imageTypeList: ImageTypeList

    @State private var startScan = false
    @State private var selectedType: Int?

    var body: some View {
        VStack {
            ScrollView {
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
                                    selectedType = index
                                    startScan = true
                                }) {
                                    Image(systemName: "plus.circle")
                                        .padding()
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
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

                    // Navigation link
                    
                    NavigationLink(destination:
                                    Screen5Submit()
                                        .environmentObject(bag)
                                        .environmentObject(imageTypeList)
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
        

        
        .sheet(isPresented: $startScan) {
            DocScan(selectedType: $selectedType)
                .environmentObject(imageTypeList)
        }

    }
}

struct Screen4FileScan_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var previews: some View {
        Screen4FileScan()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
    }
}
