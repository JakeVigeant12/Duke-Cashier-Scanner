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
                        TextField( bag.cashier?.name ?? "Name", text: $name)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("DUID")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("DUID", text: $duid)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Phone")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Phone", text: $phone)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Email")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Email", text: $email)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    
                    // TODO: need pickers
                    
                    HStack {
                        Text("Department")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Department", text: $department)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("Retail Location")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("Retail Location", text: $retailLocation)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    HStack {
                        Text("POS Name")
                            .fontWeight(.medium)
                        Spacer()
                        TextField("POS Name", text: $POSName)
                            .environment(\.colorScheme, .dark)
                            .frame(width: 170)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
                .font(.body)
                .padding([.leading, .trailing], 20)
                
                Spacer().frame(height: 40)
                HStack(spacing: 40){
                    Button(action: {
                        withAnimation{
                            clear()
                        }
                    }) {
                        Text("Clear")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.blue)
                    .opacity(0.9)
                    .cornerRadius(15)
                    
                    Button(action: {
                        submit()
                        showSuccess = true
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color.green)
                    .opacity(0.9)
                    .cornerRadius(15)
                }
                .padding(.horizontal, 50)
                .shadow(color: .black.opacity(0.2), radius: 10)
                
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.horizontal,10)
            .padding(.top, 10)
            .padding(.bottom, 10)

            .background {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.1))
                
                TransparentBlur(removeAllFilters: false)

            }
            
            
            .padding(.vertical)
            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.large)

        }
 
        
        .alert(isPresented: $showSuccess) {
            Alert(title: Text("Save Successful"), message: nil, dismissButton: .default(Text("OK")))
        }
        .onAppear(){
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.9)]
            
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
    
    func clear(){
        name = ""
        duid = ""
        phone = ""
        email = ""
        department = ""
        retailLocation = ""
        POSName = ""
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
