//
//  Screen2ProfileEdit.swift
//  eDepositBag
//
//  Created by Evan on 11/2/23.
//

import SwiftUI

struct Screen2ProfileEdit: View {
    @EnvironmentObject var imageTypeList: ImageTypeList
    @EnvironmentObject var bag: Bag
    @EnvironmentObject var tabModel: TabModel

    @State private var showSuccess = false
    
    var body: some View {
        NavigationView{
            VStack{
                // all the textfields
                ScrollView {
                    VStack(spacing: 20){
                        HStack {
                            Text("Name")
                                .fontWeight(.medium)
                            Spacer()
                            TextField("Name", text: $tabModel.userName)
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
                            TextField("DUID", text: $tabModel.userDuid)
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
                            TextField("Phone", text: $tabModel.userPhone)
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
                            TextField("Email", text: $tabModel.userEmail)
                                .environment(\.colorScheme, .dark)
                                .frame(width: 170)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        
                        // pickers
                        
                        // department
                        HStack {
                            Text("Department")
                                .fontWeight(.medium)
                            Spacer()
                            VStack{
                                Picker("Department", selection: $tabModel.userDepartment) {
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
                                
                                if (tabModel.userDepartment == "Other"){
                                    TextField("Department", text: $tabModel.userDepartmentOther)
                                        .environment(\.colorScheme, .dark)
                                        .frame(width: 170)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 15)
                                        .background(.white.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                }
                            }
                        }
                        
                        // location
                        HStack {
                            Text("Retail Location")
                                .fontWeight(.medium)
                            Spacer()
                            VStack{
                                Picker("Location", selection: $tabModel.userRetailLocation) {
                                    ForEach(tabModel.userRetailLocationList, id: \.self) { location in
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
                                if (tabModel.userRetailLocation == "Other"){
                                    TextField("Retail Location", text: $tabModel.userRetailLocationOther)
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
                            TextField("POS Name", text: $tabModel.userPOSName)
                                .environment(\.colorScheme, .dark)
                                .frame(width: 170)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .background(.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }
                    .font(.body)
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // 2 buttons
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
            }//vstack

            .foregroundStyle(.white)
            .padding(.horizontal,10)
            .padding(.vertical, 20)

            // background image
            .background {
                Image("bg1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.1))
                TransparentBlur(removeAllFilters: false)
            }
            
            // title
            .navigationTitle("User Profile")
            .navigationBarTitleDisplayMode(.large)

        }
        
        // Save Successful
        .alert(isPresented: $showSuccess) {
            Alert(title: Text("Save Successful"), message: nil, dismissButton: .default(Text("OK")))
        }
        
        // when picker changes
        .onChange(of: tabModel.userDepartment){ newValue in
            DispatchQueue.main.async {
                tabModel.userRetailLocationList = bag.locationSelections[newValue] ?? []
                // give the location picker a default choice
                if !tabModel.userRetailLocationList.contains(tabModel.userRetailLocation) {
                    tabModel.userRetailLocation = tabModel.userRetailLocationList[0]
                }
            }

        }
        
        // appearance adjustment
        .onAppear(){
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.9)]
        }
    }
    
    // save to datamodel
    func submit(){
        bag.cashier = Person(name: tabModel.userName, duid: tabModel.userDuid, phone: tabModel.userPhone, email: tabModel.userEmail, department: tabModel.userDepartment, retailLocation: tabModel.userRetailLocation, POSName: tabModel.userPOSName)
        
        bag.cashier!.department = (tabModel.userDepartment == "Other") ?  tabModel.userDepartmentOther : tabModel.userDepartment
        
        bag.cashier!.retailLocation = (tabModel.userRetailLocation == "Other") ?  tabModel.userRetailLocationOther : tabModel.userRetailLocation
        
        // save to sandbox
        let _  = bag.save()
    }
    
    func clear(){
        tabModel.userName = ""
        tabModel.userDuid = ""
        tabModel.userPhone = ""
        tabModel.userEmail = ""
        tabModel.userPOSName = ""

        if !bag.departments.isEmpty {
            tabModel.userRetailLocation = ""
            // this will trigger .onChange(of: tabModel.userDepartment)
            tabModel.userDepartment = bag.departments[0]
        }
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
