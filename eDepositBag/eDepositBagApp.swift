//
//  eDepositBagApp.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/1/23.
//

import SwiftUI

@main
struct eDepositBagApp: App {
    @StateObject var bag = Bag()
    @StateObject var person = Person(name: "", duid: "", phone: "", email: "", department: "", retailLocation: "", POSName: "")
    @StateObject var imageTypeList = ImageTypeList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bag)
                .environmentObject(imageTypeList)
        }
    }
}
