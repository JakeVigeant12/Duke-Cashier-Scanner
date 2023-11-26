//
//  MessageInbox.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/26/23.
//

import SwiftUI

struct MessageInbox: View {
    @State private var netID: String = ""
    
    @EnvironmentObject var bag: Bag
    
    var body: some View {
        Text(netID)
            .onAppear {
                bag.fetchMessages()
                
            }
    }
}


#Preview {
    MessageInbox()
}
