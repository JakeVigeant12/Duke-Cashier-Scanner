//
//  SwiftUIView.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/27/23.
//

import SwiftUI

struct MessageRow: View {
    var message:Message
    var body: some View {
        HStack{
            Text(message.content)
                .font(.subheadline)
        }
    }
}

//#Preview {
//    MessageRow()
//}
