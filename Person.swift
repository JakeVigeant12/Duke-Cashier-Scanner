//
//  Person.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/4/23.
//

import Foundation
class Person : ObservableObject, Codable, Identifiable{
    var name: String 
    var duid: String
    var phone: String
    var email: String
    var department: String
    var retailLocation: String
    var POSName: String

    init(name: String, duid: String, phone: String, email: String, department: String, retailLocation: String, POSName: String) {
        self.name = name
        self.duid = duid
        self.phone = phone
        self.email = email
        self.department = department
        self.retailLocation = retailLocation
        self.POSName = POSName
    }
    

}
