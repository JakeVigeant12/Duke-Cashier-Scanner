//
//  Docs.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/12/23.
//

import Foundation
import SwiftUI

class ImageType: ObservableObject{
    var name: String
    @Published var images: [UIImage]
    
    init(name: String, images: [UIImage]) {
        self.name = name
        self.images = images
    }
}

class ImageTypeList: ObservableObject {
    @Published var imageTypes: [ImageType]
    
    init() {
        self.imageTypes = [ImageType(name: "IRI", images: [UIImage]()),
                           ImageType(name: "HOUSE CHARGE", images: [UIImage]()),
                           ImageType(name: "SETTLEMENT REPORT\n(Mdse Concessions ONLY)", images: [UIImage]()),
                           ImageType(name: "CARS\n(Duke Technology Ctr ONLY)", images: [UIImage]()),
                           ImageType(name: "OTHER", images: [UIImage]()) ]
    }
}
