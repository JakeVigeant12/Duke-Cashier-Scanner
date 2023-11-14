//
//  Screen3BagInfoEdit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

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
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Group {
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
                }
                .font(.body)
                .padding([.leading, .trailing], 20)
                

                Spacer().frame(height: 30)
                
                Text("Enter Information for Today")
                    .font(.title2)
                    .foregroundColor(Color.blue)
                    .padding(.bottom)
                
                HStack(spacing: 40) {
                    
    //                NavigationLink(destination: Screen2ProfileEdit(bag: bag)) {
    //                    Text("No")
    //                        .foregroundColor(.white)
    //                        .frame(maxWidth: .infinity)
    //                        .padding()
    //                        .background(Color.red)
    //                        .opacity(0.8)
    //                        .cornerRadius(15)
    //                }
    //                .simultaneousGesture(TapGesture().onEnded {
    //                    submit()
    //                })
                    
                    NavigationLink(destination: Screen4AskScanBarcode()
                        .environmentObject(bag)
                        .environmentObject(imageTypeList)) {
                        Text("Done")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .opacity(0.8)
                            .cornerRadius(15)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        submit()
                    })
                }
                .padding(.horizontal, 50.0)
                
                Spacer()
            }
            .padding(.vertical)
            .navigationTitle("Deposit Bag Info")
            .navigationBarTitleDisplayMode(.inline)

        }
        
        .onAppear(){
            let _ = bag.parseOptions(url: Bag.selectionOptions!)
            
            if let cashier = bag.cashier {
                name = cashier.name
                duid = cashier.duid
                phone = cashier.phone
                email = cashier.email
                department = cashier.department
                retailLocation = cashier.retailLocation
                POSName = cashier.POSName
            }
        }

    }
    func submit(){
        //set this information for the bag, account defaults should be changed separate
        bag.POSName = POSName
        bag.retailLocation = (retailLocation == "Other") ?  retailLocationOther : retailLocation
        bag.department = (department == "Other") ?  departmentOther : department
    }
    func getLocations() -> [String]{
        return bag.locationSelections[department] ?? []
    }


    }
    

struct Screen3BagInfoEdit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var previews: some View {
        Screen3BagInfoEdit()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
    }
}
