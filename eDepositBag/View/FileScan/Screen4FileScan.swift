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
        VStack{
            List{
                
                ForEach(imageTypeList.imageTypes.indices, id: \.self) { index in
                    let imageType = imageTypeList.imageTypes[index]
                    
                    Section(header: 
                        HStack{
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
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }

                    }) {
                        ListRow(imageType: imageTypeList.imageTypes[index])
                    }
                }
            }

            
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
            .padding(.top)
            .background(Color.blue)
            .opacity(0.8)

        }

        .navigationTitle("Scan Documents")
        .navigationBarTitleDisplayMode(.inline)
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
