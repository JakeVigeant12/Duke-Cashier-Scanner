//
//  TabViewModel.swift
//  eDepositBag
//
//  Created by Evan on 12/5/23.
//

import Foundation


// tabview tags
enum TabViewTag {
    case bag
    case person
    case inbox
}

// data model for tabview, so that when switch tags the data won't be changed or reinitialized
class TabModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userDuid: String = ""
    @Published var userPhone: String = ""
    @Published var userEmail: String = ""
    
    @Published var userDepartment: String = ""
    @Published var userDepartmentOther: String = ""
    @Published var userRetailLocation: String = ""
    @Published var userRetailLocationOther: String = ""
    @Published var userRetailLocationList: [String] = []
    @Published var userPOSName: String = ""
    
    @Published var bagDepartment: String = ""
    @Published var bagDepartmentOther: String = ""
    @Published var bagRetailLocation: String = ""
    @Published var bagRetailLocationOther: String = ""
    @Published var bagRetailLocationList: [String] = []
    @Published var bagPOSName: String = ""
    @Published var bagRevenueDatePicker: Date = Date()
    
    @Published var bagScannedCode: String?
}
