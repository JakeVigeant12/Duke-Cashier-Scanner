//
//  Screen2ProfileEdit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen2ProfileEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var imageTypeList: ImageTypeList
    
    var bag: Bag

    @State private var name:String
    @State private var duid:String
    @State private var phone:String
    @State private var email:String
    @State private var department:String
    @State private var retailLocation: String
    @State private var POSName: String
    
    init(bag: Bag) {
        self.bag = bag
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
               Group{
                   HStack {
                       Text("Name")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("Name", text: $name)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
                   HStack {
                       Text("DUID")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("DUID", text: $duid)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
                   HStack {
                       Text("Phone")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("Phone", text: $phone)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
                   HStack {
                       Text("Email")
                           .fontWeight(.medium)
                       Spacer()
                       TextField("Email", text: $email)
                           .multilineTextAlignment(.center)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .frame(width: 200)
                   }
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
               
               Spacer().frame(height: 40)

               Button(action: {
                   presentationMode.wrappedValue.dismiss()
                   submit()
               }) {
                   Text("Save")
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
                       .padding()
               }
               .background(Color.blue)
               .opacity(0.9)
               .cornerRadius(15)
               .padding(.horizontal, 70.0)
               
               Spacer()
           }
           .padding(.vertical)
           .navigationTitle("User Profile")
           .navigationBarTitleDisplayMode(.inline)
       }
    func submit(){
        bag.cashier = Person(name: name, duid: duid, phone: phone, email: email, department: department, retailLocation: retailLocation, POSName: POSName)
        let _  = bag.save()
    }
}


struct Screen2ProfileEdit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var previews: some View {
        let bag = Bag()
        Screen2ProfileEdit(bag: bag)
            .environmentObject(imageTypeList)

    }
}
