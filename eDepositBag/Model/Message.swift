//
//  Message.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/26/23.
//

import Foundation
//MARK: Used to parse JSON response for Messages
struct Message: Identifiable, Codable {
    let id: UUID
    let content: String

    init(id: UUID, content: String) {
        self.id = id
        self.content = content
    }
}
