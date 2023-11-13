//
//  Docs.swift
//  eDepositBag
//
//  Created by Fall 2023 on 11/12/23.
//

import Foundation

class ImageType: ObservableObject{
    @Published var name: String
    @Published var images: [String]
    var imageNum: Int
    
    init(name: String, images: [String], imageNum: Int) {
        self.name = name
        self.images = images
        self.imageNum = imageNum
    }
}

class ImageTypeList: ObservableObject {
    @Published var imageTypes: [ImageType]
    
    init() {
        self.imageTypes = [ImageType(name: "IRI", images: ["person","camera","pencil"], imageNum: 0),
                           ImageType(name: "HOUSE CHARGE", images: [String](), imageNum: 0),
                           ImageType(name: "SETTLEMENT REPORT\n(Mdse Concessions ONLY)", images: [String](), imageNum: 0),
                           ImageType(name: "CARS\n(Duke Technology Ctr ONLY)", images: [String](), imageNum: 0),
                           ImageType(name: "OTHER", images: [String](), imageNum: 0) ]
    }
}
