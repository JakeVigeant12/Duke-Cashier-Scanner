//
//  Bag.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/2/23.

import Foundation
class Bag : ObservableObject{
    @Published var cashier: Person?
    @Published var department: String = ""
    @Published var retailLocation: String = ""
    @Published var POSName: String = ""
    @Published var bagNum: Int?
    @Published var imageScans: [String:String] = [:]
    @Published var revenueDate: String = ""
    
    func printit(){   
        print("hi")
    }
}
