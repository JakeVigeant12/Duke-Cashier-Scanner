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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bag)
        }
    }
}
