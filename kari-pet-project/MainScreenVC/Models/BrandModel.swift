//
//  BrandModel.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct BrandModel: Decodable {
    let id: String
    let importName: String
    let updated: String
    let image: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case importName
        case updated
        case image
        case name
    }
}
