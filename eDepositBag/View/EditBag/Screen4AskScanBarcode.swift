//
//  Screen4AskScanBarcode.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI
import Combine

struct Screen4AskScanBarcode: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var imageTypeList: ImageTypeList

    @State private var name:String
    @State private var duid:String
    @State private var phone:String
    @State private var email:String
    @State private var department:String
    @State private var retailLocation: String
    @State private var POSName: String
    @State private var revenueDatePicker: Date = Date()
    
    init(bag: Bag) {
        _name = State(initialValue: "")
        _duid = State(initialValue: "")
        _phone = State(initialValue: "")
        _email = State(initialValue: "")
        _department = State(initialValue: "")
        _retailLocation = State(initialValue: "")
        _POSName = State(initialValue: "")
        
        if let cashier = bag.cashier {
            _name = State(initialValue: cashier.name)
            _duid = State(initialValue: cashier.duid)
            _phone = State(initialValue: cashier.phone)
            _email = State(initialValue: cashier.email)
        }
        
        _department = State(initialValue: bag.department)
        _retailLocation = State(initialValue: bag.retailLocation)
        _POSName = State(initialValue: bag.POSName)

    }

    @State private var bagNum: Int?
    @State private var scannedCode: String?
    @State private var isScanFail = false
    
    enum ShowView{
        case ask, next, showBagNum
    }
    
    @State private var showView = ShowView.ask
    @State private var startScan = false
    
    var body: some View {
        VStack(spacing: 20) {
            Group{
                HStack {
                    Text("Department")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Department", text: $department)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("Retail Location")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("Retail Location", text: $retailLocation)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
                HStack {
                    Text("POS Name")
                        .fontWeight(.medium)
                    Spacer()
                    TextField("POS Name", text: $POSName)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                }
            }
            //can not be edited
            .disabled(true)

            .padding([.leading, .trailing], 20)
            
            HStack {
                Text("Revenue Date")
                    .fontWeight(.medium)
                Spacer()
                if(showView == .next){
                    DatePicker("Select a date", selection: $revenueDatePicker, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())                         .labelsHidden()
                        .disabled(true)
                }else{
                    DatePicker("Select a date", selection: $revenueDatePicker, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())                         .labelsHidden()
               
                    
                    
//                    TextField("Revenue Date", text: Binding(
//                        get: { self.revenueDate },
//                        set: { newValue in
//                            self.revenueDate = newValue
//                            bag.revenueDate = newValue
//                        }
//                    ))
//                    .multilineTextAlignment(.center)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .frame(width: 200)


                }
            }
            .padding([.top, .leading, .trailing], 20)
            
            
            if(showView == .next){
                HStack {
                    Text("Bag Number")
                        .fontWeight(.medium)
                    Spacer()

                    if let code = scannedCode{
                        Text(code)
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            .foregroundColor(.blue)
                    }else{
                        Text("No Bag Number")
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            .foregroundColor(.blue)
                    }

                }
                .padding([.top, .leading, .trailing], 20)
            }

            
            
            Spacer().frame(height: 30)

            switch showView {
            case .ask:
                Group{
                    Text("Are you sending cash deposit to University Cashiering?")
                        .font(.title2)
                        .foregroundColor(Color.blue)
                        .multilineTextAlignment(.center)

                    HStack(spacing: 40) {

                        
                        Button(action: {
                            bag.revenueDate = getDateString(currentDate: revenueDatePicker)
                            withAnimation{
                                scannedCode = nil
                                showView = .next
                            }
                        }) {
                            Text("No")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color.red)
                        .opacity(0.8)
                        .cornerRadius(15)
                        
                        Button(action: {
                            withAnimation{
                                showView = .showBagNum
                            }
                        }) {
                            Text("Yes")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color.green)
                        .opacity(0.8)
                        .cornerRadius(15)
                    }
                    .padding(.horizontal, 50.0)
                }
            case .next:
                HStack(spacing: 40) {
                    Button(action: {
                        withAnimation{
                            showView = .ask
                            
                            
                        }
                    }) {
                        Text("Back")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.red)
                    .opacity(0.8)
                    .cornerRadius(15)
                    
                    NavigationLink(destination: Screen5FileScan(bag:bag)
                        .environmentObject(imageTypeList)) {
                        Text("Next")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.green)
                    .opacity(0.8)
                    .cornerRadius(15)
                }
                .padding(.horizontal, 50.0)
            case .showBagNum:
                Group{
                    Text("Please press the button below to scan the barcode on the deposit bag.")
                        .font(.title2)
                        .foregroundColor(Color.blue)
                        .padding(.bottom)
                        .multilineTextAlignment(.center)
                    
                    if (isScanFail) {
                        Text("Scanning failed. Please try again.")
                            .font(.title2)
                            .foregroundColor(Color.red)
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        Text("Bag Number")
                            .fontWeight(.medium)
                        Spacer()
                            
                        Button(action: {
                            withAnimation {
                                startScan = true
                            }
                        }) {
                            if let code = scannedCode{
                                Text(code)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }else{
                                Text("Scan")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                        .background(Color.blue)
                        .opacity(0.7)
                        .cornerRadius(15)
                        .frame(width: 200)
                    }
                    .padding([.top, .leading, .trailing], 20)
                }
            }
            Spacer()
        }
        .padding(.vertical)
     
        .navigationTitle("Date and Bag Number")
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(isPresented: $startScan, onDismiss: scanSheetDismissed) {
            BarcodeScan(isPresentingScanner: self.$startScan, scannedCode: self.$scannedCode, isScanFail: self.$isScanFail)
        }
        
        .onAppear{
            // TODO
            
            if let num = bagNum {
                scannedCode = String(num)
            }else{
                scannedCode = nil
            }
        }
    }
    
    func scanSheetDismissed() {
        if(!isScanFail){
            bag.revenueDate = getDateString(currentDate: revenueDatePicker)
            showView = .next
            
            if let scanned = scannedCode {
                if let num = Int(scanned) {
                    bag.bagNum = num
                }
            }
        }
    }

}

func getDateString(currentDate:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: currentDate)
    return dateString
}
struct Screen4AskScanBarcode_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var previews: some View {
        let bag = Bag()
        Screen4AskScanBarcode(bag:bag)
            .environmentObject(imageTypeList)
    }
}
