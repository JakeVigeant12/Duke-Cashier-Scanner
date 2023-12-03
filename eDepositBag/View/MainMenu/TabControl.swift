//
//  TabControl.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/14/23.
//

import SwiftUI

enum Tab {
    case bag
    case person
    case inbox
}

class TabModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userDuid: String = ""
    @Published var userPhone: String = ""
    @Published var userEmail: String = ""
    
    @Published var userDepartment: String = ""
    @Published var userRetailLocation: String = ""
    @Published var userPOSName: String = ""
    
    @Published var bagName: String = ""
    @Published var bagDuid: String = ""
    @Published var bagPhone: String = ""
    @Published var bagEmail: String = ""
    
    @Published var bagDepartment: String = ""
    @Published var bagDepartmentOther: String = ""
    @Published var bagRetailLocation: String = ""
    @Published var bagRetailLocationOther: String = ""
    @Published var bagRetailLocationList: [String] = []
    @Published var bagPOSName: String = ""
    @Published var bagRevenueDatePicker: Date = Date()
    
    @Published var bagScannedCode: String?

}


struct TabControl: View {
    
    // create and load the data model
    @StateObject var bag = Bag()
    @StateObject var imageTypeList = ImageTypeList()
    @StateObject var tableModel = TabModel()
    
    @State var selection: Tab
    
    var body: some View {
        TabView(selection: $selection){

            
            Screen2ProfileEdit()
                .environmentObject(bag)
                .environmentObject(imageTypeList)
                .environmentObject(tableModel)
            
                .tabItem {
                    Label("User", systemImage: "person")
                }
                .tag(Tab.person)

            Screen3BagInfoEdit()
                .environmentObject(bag)
                .environmentObject(imageTypeList)
                .environmentObject(tableModel)
            
                .tabItem {
                    Label("Bag", systemImage: "doc")
                }
                .tag(Tab.bag)
            
            MessageInbox()
                .environmentObject(bag)
                .tabItem {
                    Label("Inbox" + (bag.messages.count > 0 ? " - \(bag.messages.count)" : ""), systemImage: "message")
                }
                .tag(Tab.inbox)
            
        }
        .environment(\.colorScheme, .dark)
        .accentColor(.white)
        .navigationBarBackButtonHidden(true)
 
        .onAppear(){
            // Parse
            let _ = bag.parseOptions(url: Bag.selectionOptions!)
            let _ = bag.load(url: Bag.sandboxUser)
            let _ = bag.fetchMessages()

            if let cashier = bag.cashier {
                tableModel.userName = cashier.name
                tableModel.userDuid = cashier.duid
                tableModel.userPhone = cashier.phone
                tableModel.userEmail = cashier.email
                tableModel.userDepartment = cashier.department
                tableModel.userRetailLocation = cashier.retailLocation
                tableModel.userPOSName = cashier.POSName
                
                tableModel.bagDepartment = cashier.department
                tableModel.bagRetailLocation = cashier.retailLocation
                tableModel.bagPOSName = cashier.POSName
                
                tableModel.bagRetailLocationList = bag.locationSelections[tableModel.bagDepartment] ?? []
            }
            
            // give the picker a default choice
            if !bag.departments.isEmpty && tableModel.bagRetailLocationList.isEmpty {
                tableModel.bagDepartment = bag.departments[0]
                tableModel.bagRetailLocationList = bag.locationSelections[tableModel.bagDepartment] ?? []
            }
            
            if bag.bagNum != 0 {
                tableModel.bagScannedCode = String(bag.bagNum)
            }else{
                tableModel.bagScannedCode = nil
            }
            
        }
    }//body

}

struct TabControl_Previews: PreviewProvider {
    static var previews: some View {
        TabControl(selection: Tab.bag)
    }
}
