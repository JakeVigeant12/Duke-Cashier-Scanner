//
//  eDepositBagApp.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/1/23.
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
