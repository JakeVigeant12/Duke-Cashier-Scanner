//
//  eDepositBagApp.swift
//  eDepositBag
//
//  Created by Evan on 11/1/23.
//

import SwiftUI

@main
struct eDepositBagApp: App {
    @StateObject private var bag = Bag()
    var body: some Scene {
        WindowGroup {
            MainMenu()
                .environmentObject(bag)
        }
    }
}
