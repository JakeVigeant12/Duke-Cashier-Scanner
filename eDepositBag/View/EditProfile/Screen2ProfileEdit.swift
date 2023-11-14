//
//  Screen2ProfileEdit.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/2/23.
//

import SwiftUI

struct Screen2ProfileEdit: View {

    @EnvironmentObject var imageTypeList: ImageTypeList
    @EnvironmentObject var bag: Bag

    @State private var name: String = ""
    @State private var duid: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var department: String = ""
    @State private var retailLocation: String = ""
    @State private var POSName: String = ""

    @State private var showSuccess = false
    
    var body: some View {
        NavigationView{
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
                    
                    // TODO: need pickers
                    
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
                    submit()
                    showSuccess = true
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
        
        .alert(isPresented: $showSuccess) {
            Alert(title: Text("Save Successful"), message: nil, dismissButton: .default(Text("OK")))
        }
        .onAppear(){
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
        bag.cashier = Person(name: name, duid: duid, phone: phone, email: email, department: department, retailLocation: retailLocation, POSName: POSName)
        let _  = bag.save()
    }
}


struct Screen2ProfileEdit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var previews: some View {

        Screen2ProfileEdit()
            .environmentObject(bag)
            .environmentObject(imageTypeList)

    }
}
