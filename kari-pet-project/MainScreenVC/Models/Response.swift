//
//  Response.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let blocks: [Block]
    
    private enum CodingKeys: String, CodingKey {
        case blocks = "data"
    }
}
