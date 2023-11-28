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
    @EnvironmentObject var tableModel: TabModel
    
    @State private var isScanFail = false
    
    enum ShowView{
        case ask, next, showBagNum
    }
    
    @State private var showView = ShowView.ask
    @State private var startScan = false
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView{
                    VStack(spacing: 20) {
                        HStack {
                            Text("Department")
                                .fontWeight(.medium)
                            Spacer()
                            VStack{
                                Picker("Department", selection: $tableModel.bagDepartment) {
                                    ForEach(bag.departments, id: \.self) { dept in
                                        Text(dept)
                                    }
                                }
                                
                                .environment(\.colorScheme, .dark)
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 170)
                                .padding(.vertical,4)
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                
                                if (tableModel.bagDepartment == "Other"){
                                    TextField("Department", text: $tableModel.bagDepartmentOther)
                                        .environment(\.colorScheme, .dark)
                                        .frame(width: 170)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 15)
                                        .background(.white.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                }
                            }
                        }
                        HStack {
                            Text("Retail Location")
                                .fontWeight(.medium)
                            Spacer()
                            VStack{
                                Picker("Location", selection: $tableModel.bagRetailLocation) {
                                    ForEach(tableModel.bagRetailLocationList, id: \.self) { location in
                                        Text(location)
                                    }
                                }
                                .environment(\.colorScheme, .dark)
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 170)
                                .padding(.vertical,4)
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                if (tableModel.bagRetailLocation == "Other"){
                                    TextField("Retail Location", text: $tableModel.bagRetailLocationOther)
                                        .environment(\.colorScheme, .dark)
                                        .frame(width: 170)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 15)
                                        .background(.white.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                }
                            }

                        }
                        HStack {
                            Text("POS Name")
                                .fontWeight(.medium)
                            Spacer()
                            TextField("POS Name", text: $tableModel.bagPOSName)
                                .environment(\.colorScheme, .dark)
                                .frame(width: 170)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        
                        HStack {
                            Text("Revenue Date")
                                .fontWeight(.medium)
                            Spacer()
                            DatePicker("Select a date", selection: $tableModel.bagRevenueDatePicker, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                                .environment(\.colorScheme, .dark)
                                .frame(width: 170)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 15)
                 
                        }
                    }
                    //can not be edited
                    .disabled(showView == .next ? true : false)
                    .font(.body)
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 20)
                }
                
                if(showView == .next){
                    HStack {
                        Text("Bag Number")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        Spacer()

                        if let code = tableModel.bagScannedCode{
                            Text(code)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 200)
                                .foregroundColor(.blue)
                        }else{
                            Text("No Bag Number")
                                .environment(\.colorScheme, .dark)
                                .frame(width: 170)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }

                    }
                    .padding([.top, .leading, .trailing], 20)
                }
                
                Spacer()
                VStack{
                    Spacer()
                    switch showView {
                    case .ask:
                        Text("Are you sending cash deposit to University Cashiering?")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)

                        HStack(spacing: 40) {
                            Button(action: {
                                bag.revenueDate = getDateString(currentDate: tableModel.bagRevenueDatePicker)
                                submit()
                                withAnimation{
                                    tableModel.bagScannedCode = nil
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
                        .shadow(color: .black.opacity(0.2), radius: 10)
                        .padding(.top, 20)
                        
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
                                .environmentObject(imageTypeList)
                                .environmentObject(tableModel)
                            ) {
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
                        .shadow(color: .black.opacity(0.2), radius: 10)
                    case .showBagNum:
                        Text("Please press the button below to scan the barcode on the deposit bag.")
                            .font(.title2)
                            .foregroundColor(Color.white)
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
                                .foregroundStyle(.white)
                            Spacer()
                                
                            Button(action: {
                                withAnimation {
                                    startScan = true
                                }
                            }) {
                                if let code = tableModel.bagScannedCode{
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
                            .background(Color.blue.opacity(0.8))
                            .cornerRadius(15)
                            .frame(width: 200)
                            .shadow(color: .black.opacity(0.2), radius: 10)
                        }
                        .padding([.top, .leading, .trailing], 20)
                    }

                }

            }
            .foregroundStyle(.white)
            .padding(.horizontal,10)
            .padding(.vertical, 20)

            
            .background {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.1))
                TransparentBlur(removeAllFilters: false)
            }

            .navigationTitle("Deposit Bag Info")
            .navigationBarTitleDisplayMode(.large)
        }

        
        .sheet(isPresented: $startScan, onDismiss: scanSheetDismissed) {
            BarcodeScan(isPresentingScanner: self.$startScan, scannedCode: self.$tableModel.bagScannedCode, isScanFail: self.$isScanFail)
        }
        
        .onAppear{
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.9)]
            // TODO: need info from screen2
            
        }
        
        .onChange(of: tableModel.bagDepartment){ _ in
            tableModel.bagRetailLocationList = bag.locationSelections[tableModel.bagDepartment] ?? []
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
        bag.department = (tableModel.bagDepartment == "Other") ?  tableModel.bagDepartmentOther : tableModel.bagDepartment
        
        bag.retailLocation = (tableModel.bagRetailLocation == "Other") ?  tableModel.bagRetailLocationOther : tableModel.bagRetailLocation

        bag.POSName = tableModel.bagPOSName
        
        bag.revenueDate = getDateString(currentDate: tableModel.bagRevenueDatePicker)
        
        if let scanned = tableModel.bagScannedCode {
            if let num = Int(scanned) {
                bag.bagNum = num
            }
        }
    }
    
    func getDateString(currentDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
}



struct Screen3BagInfoEdit_Previews: PreviewProvider {
    static var previews: some View {
        TabControl(selection: Tab.bag)
    }
}
