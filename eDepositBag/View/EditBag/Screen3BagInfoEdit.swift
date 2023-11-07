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

    @State private var name:String
    @State private var duid:String
    @State private var phone:String
    @State private var email:String
    @State private var department:String
    @State private var retailLocation: String
    @State private var POSName: String
    
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
            _department = State(initialValue: cashier.department)
            _retailLocation = State(initialValue: cashier.retailLocation)
            _POSName = State(initialValue: cashier.POSName)
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            Group {
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
                
                NavigationLink(destination: Screen4AskScanBarcode(bag: bag)) {
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
    func submit(){
        //set this information for the bag, account defaults should be changed separate
        bag.POSName = POSName
        bag.retailLocation = retailLocation
        bag.department = department
    }
    }


struct Screen3BagInfoEdit_Previews: PreviewProvider {
    static var previews: some View {
        let bag = Bag()
        Screen3BagInfoEdit(bag : bag)
            .environmentObject(bag)
    }
}
