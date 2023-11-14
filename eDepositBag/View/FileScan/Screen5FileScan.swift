//
//  Screen5FileScan.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen5FileScan: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var startScan = false
    @State private var selectedType: Int?
    
    @StateObject var imageTypeList = ImageTypeList()
    
    private var bag:Bag
    @State private var bagNum: Int
    @State private var name:String
    @State private var duid:String
    @State private var phone:String
    @State private var email:String
    @State private var department:String
    @State private var retailLocation: String
    @State private var POSName: String
    @State private var revenueDate: String
    
    init(bag: Bag) {
        self.bag = bag
        _name = State(initialValue: "")
        _duid = State(initialValue: "")
        _phone = State(initialValue: "")
        _email = State(initialValue: "")
        _department = State(initialValue: "")
        _retailLocation = State(initialValue: "")
        _POSName = State(initialValue: "")
        _revenueDate = State(initialValue: "")

        if let cashier = bag.cashier {
            _name = State(initialValue: cashier.name)
            _duid = State(initialValue: cashier.duid)
            _phone = State(initialValue: cashier.phone)
            _email = State(initialValue: cashier.email)
        }
        
        _department = State(initialValue: bag.department)
        _retailLocation = State(initialValue: bag.retailLocation)
        _POSName = State(initialValue: bag.POSName)
        _revenueDate = State(initialValue: bag.revenueDate)
        _bagNum = State(initialValue: bag.bagNum)

    }
    
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
                            Screen6Submit(bag:bag)
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



struct Screen5FileScan_Previews: PreviewProvider {
    static var previews: some View {
        let bag = Bag()
        Screen5FileScan(bag:bag)
    }
}
