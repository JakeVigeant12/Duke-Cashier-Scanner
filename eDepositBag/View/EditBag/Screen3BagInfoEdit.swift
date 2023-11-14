//
//  Screen4AskScanBarcode.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI
import Combine

struct Screen3BagInfoEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var imageTypeList: ImageTypeList

    @State private var name: String = ""
    @State private var duid: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var department: String = ""
    @State private var departmentOther: String = ""
    @State private var retailLocation: String = ""
    @State private var retailLocationOther: String = ""
    @State private var POSName: String = ""
    @State private var revenueDatePicker: Date = Date()

    @State private var bagNum: Int?
    @State private var scannedCode: String?
    @State private var isScanFail = false
    
    enum ShowView{
        case ask, next, showBagNum
    }
    
    @State private var showView = ShowView.ask
    @State private var startScan = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group{
                    HStack {
                        Text("Department")
                            .fontWeight(.medium)
                        Spacer()
                        VStack{
                            Picker("Department", selection: $department) {
                                ForEach(bag.departments, id: \.self) { dept in
                                    Text(dept)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            
                            if (department == "Other"){
                                TextField("Department", text: $departmentOther)
                                    .multilineTextAlignment(.center)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 200)                        }
                        }
                    }
                    HStack {
                        Text("Retail Location")
                            .fontWeight(.medium)
                        Spacer()
                        VStack{
                            Picker("Location", selection: $retailLocation) {
                                ForEach(getLocations(), id: \.self) { location in
                                    Text(location)
                                }
                            }
                            
                            .pickerStyle(MenuPickerStyle())
                            .multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            if (retailLocation == "Other"){
                                TextField("Retail Location", text: $retailLocationOther)
                                    .multilineTextAlignment(.center)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 200)                        }
                        }

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
                    
                    HStack {
                        Text("Revenue Date")
                            .fontWeight(.medium)
                        Spacer()
                        DatePicker("Select a date", selection: $revenueDatePicker, displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                            .multilineTextAlignment(.center)
                            .frame(width: 200)
                    }
                }
                //can not be edited
                .disabled(showView == .next ? true : false)
                .font(.body)
                .padding([.leading, .trailing], 20)
                

                
                
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
                        
                        NavigationLink(destination: Screen4FileScan()
                            .environmentObject(bag)
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
         
            .navigationTitle("Deposit Bag Info")
            .navigationBarTitleDisplayMode(.inline)
        }

        
        .sheet(isPresented: $startScan, onDismiss: scanSheetDismissed) {
            BarcodeScan(isPresentingScanner: self.$startScan, scannedCode: self.$scannedCode, isScanFail: self.$isScanFail)
        }
        
        .onAppear{
            // TODO: need info from screen2
            
            // give the picker a default choice
            if bag.departments.count != 0 {
                department = bag.departments[0]
            }
            
            if let cashier = bag.cashier {
                name = cashier.name
                duid = cashier.duid
                phone = cashier.phone
                email = cashier.email
                department = cashier.department
                retailLocation = cashier.retailLocation
                POSName = cashier.POSName
            }
            
            if bag.bagNum != 0 {
                scannedCode = String(bag.bagNum)
            }else{
                scannedCode = nil
            }
            

        }
    }
    
    func scanSheetDismissed() {
        if(!isScanFail){
            submit()
            showView = .next
        }
    }
    
    func submit(){
        //set this information for the bag, account defaults should be changed separate
        bag.department = (department == "Other") ?  departmentOther : department
        
        bag.retailLocation = (retailLocation == "Other") ?  retailLocationOther : retailLocation

        bag.POSName = POSName
        
        bag.revenueDate = getDateString(currentDate: revenueDatePicker)
        
        if let scanned = scannedCode {
            if let num = Int(scanned) {
                bag.bagNum = num
            }
        }
    }
    
    func getLocations() -> [String]{
        return bag.locationSelections[department] ?? []
    }
    
    func getDateString(currentDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
}



struct Screen3BagInfoEdit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    
    static var previews: some View {
        Screen3BagInfoEdit()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
            .onAppear(){
                // Parse
                let _ = bag.parseOptions(url: Bag.selectionOptions!)
            }
    }
}
