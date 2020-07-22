//
//  RecomendedProducts.swift
//  kari-pet-project
//
//  Created by Admin on 21.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct RecomendedProducts: Encodable {
    var locationId: String
    var size: Int
    var page: Int
    var uniqueSizeIds: [String]
}
