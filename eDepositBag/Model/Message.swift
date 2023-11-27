//
//  Message.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/26/23.
//

import Foundation
struct Message: Identifiable, Codable {
    let id: UUID
    let content: String

    init(id: UUID, content: String) {
        self.id = id
        self.content = content
    }
}
