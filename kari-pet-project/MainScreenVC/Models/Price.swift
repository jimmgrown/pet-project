//
//  Price.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct Price: Decodable {
    let current: Int
    let first: Int?
    let discount: Int?
}
