//
//  TabControl.swift
//  eDepositBag
//
//  Created by Evan on 11/14/23.
//

import SwiftUI

// tab view control, and initialize most of the data
struct TabControl: View {
    @EnvironmentObject var bag: Bag
    @StateObject var imageTypeList = ImageTypeList()
    // create and load the data model
    @StateObject var tabModel = TabModel()
    @State var selection: TabViewTag
    
    var body: some View {
        // 3 tabs
        TabView(selection: $selection){
            Screen2ProfileEdit()
                .environmentObject(bag)
                .environmentObject(imageTypeList)
                .environmentObject(tabModel)
            
                .tabItem {
                    Label("User", systemImage: "person")
                }
                .tag(TabViewTag.person)

            Screen3BagInfoEdit()
                .environmentObject(bag)
                .environmentObject(imageTypeList)
                .environmentObject(tabModel)
            
                .tabItem {
                    Label("Bag", systemImage: "doc")
                }
                .tag(TabViewTag.bag)
            
            MessageInbox()
                .environmentObject(bag)
                .tabItem {
                    Label("Inbox" + (bag.messages.count > 0 ? " - \(bag.messages.count)" : ""), systemImage: "message")
                }
                .tag(TabViewTag.inbox)
            
        }
        .environment(\.colorScheme, .dark)
        .accentColor(.white)
        .navigationBarBackButtonHidden(true)
 
        // init datamodel
        .onAppear(){
            DispatchQueue.main.async {
                // init the tabmodel, so that when switch tabs the data won't be reinitialized
                if let cashier = bag.cashier {
                    tabModel.userName = cashier.name
                    tabModel.userDuid = cashier.duid
                    tabModel.userPhone = cashier.phone
                    tabModel.userEmail = cashier.email

                    tabModel.userPOSName = cashier.POSName
                    tabModel.bagPOSName = cashier.POSName
                    
                    // if department is "Other"
                    if cashier.department != "" && !bag.departments.contains(cashier.department){
                        tabModel.bagDepartment = "Other"
                        tabModel.userDepartment = "Other"
                        tabModel.bagDepartmentOther = cashier.department
                        tabModel.userDepartmentOther = cashier.department
                    }else{
                        // department is empty or not "Other"
                        tabModel.bagDepartment = cashier.department
                        tabModel.userDepartment = cashier.department
                    }
                    
                    tabModel.userRetailLocationList = bag.locationSelections[tabModel.bagDepartment] ?? []
                    tabModel.bagRetailLocationList = tabModel.userRetailLocationList
                    
                    // if retailLocation is "Other"
                    if cashier.retailLocation != "" && !tabModel.bagRetailLocationList.contains(cashier.retailLocation){
                        tabModel.bagRetailLocation = "Other"
                        tabModel.userRetailLocation = "Other"
                        tabModel.bagRetailLocationOther = cashier.retailLocation
                        tabModel.userRetailLocationOther = cashier.retailLocation
                    }else{
                        // retailLocation is empty or not "Other"
                        tabModel.bagRetailLocation = cashier.retailLocation
                        tabModel.userRetailLocation = cashier.retailLocation
                    }
                }
                
                // if there is no cashier or no department, give each department pickers a default choice
                if tabModel.userDepartment == "" && !bag.departments.isEmpty{
                    tabModel.userDepartment = bag.departments[0]
                    tabModel.bagDepartment = tabModel.userDepartment
                    tabModel.userRetailLocationList = bag.locationSelections[tabModel.bagDepartment] ?? []
                    tabModel.bagRetailLocationList = tabModel.userRetailLocationList
                }
                
                // give each location pickers a default choice
                if tabModel.userRetailLocation == "" && !tabModel.userRetailLocationList.isEmpty {
                    tabModel.userRetailLocation = tabModel.userRetailLocationList[0]
                    tabModel.bagRetailLocation = tabModel.userRetailLocation
                }
                
                bag.bagNum = "No Bag Number"
                tabModel.bagScannedCode = nil
            }
        }
           
    }//body

}

struct TabControl_Previews: PreviewProvider {
    static var previews: some View {
        let bag = Bag()
        TabControl(selection: TabViewTag.bag)
            .environmentObject(bag)
    }
}
