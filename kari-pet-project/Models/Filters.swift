//
//  Filters.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct Filters: Decodable {
    let sort: String?
    let guids: [String]?
    let tags: [String]?
    let isPopular: Bool?
    //let season:String?
}
