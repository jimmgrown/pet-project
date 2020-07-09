//
//  Response.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct ResponseMainScreen: Decodable {
    let blocks: [Block]
    //public typealias Response = [Block]
    public var resourceName: String {
        return "https://i.api.kari.com/mobile/v2/screen/main?locationId=7400000100000&client=app_mobile"
    }
    
    private enum CodingKeys: String, CodingKey {
        case blocks = "data"
    }
}
