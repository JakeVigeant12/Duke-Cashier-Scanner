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
    @EnvironmentObject var tableModel: TabModel

    @State private var showSuccess = false
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView {
                    VStack(spacing: 20){
                        HStack {
                            Text("Name")
                                .fontWeight(.medium)
                            Spacer()
                            TextField("Name", text: $tableModel.userName)
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
                            TextField("DUID", text: $tableModel.userDuid)
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
                            TextField("Phone", text: $tableModel.userPhone)
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
                            TextField("Email", text: $tableModel.userEmail)
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
                            TextField("Department", text: $tableModel.userDepartment)
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
                            TextField("Retail Location", text: $tableModel.userRetailLocation)
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
                            TextField("POS Name", text: $tableModel.userPOSName)
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

                }
                Spacer()
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
                    .background(Color.blue.opacity(0.8))
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
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(15)
                }
                .padding(.horizontal, 50)
                .shadow(color: .black.opacity(0.2), radius: 10)
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
            

            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.large)

        }
        
        .alert(isPresented: $showSuccess) {
            Alert(title: Text("Save Successful"), message: nil, dismissButton: .default(Text("OK")))
        }
        .onAppear(){
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.9)]
        }
    }
    func submit(){
        bag.cashier = Person(name: tableModel.userName, duid: tableModel.userDuid, phone: tableModel.userPhone, email: tableModel.userEmail, department: tableModel.userDepartment, retailLocation: tableModel.userRetailLocation, POSName: tableModel.userPOSName)
        let _  = bag.save()
    }
    
    func clear(){
        tableModel.userName = ""
        tableModel.userDuid = ""
        tableModel.userPhone = ""
        tableModel.userEmail = ""
        tableModel.userDepartment = ""
        tableModel.userRetailLocation = ""
        tableModel.userPOSName = ""
    }
}


struct Screen2ProfileEdit_Previews: PreviewProvider {
    static var imageTypeList = ImageTypeList()
    static var bag = Bag()
    static var tableModel = TabModel()
    static var previews: some View {

        Screen2ProfileEdit()
            .environmentObject(bag)
            .environmentObject(imageTypeList)
            .environmentObject(tableModel)

    }
}
