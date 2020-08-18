//
//  Action.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct Action: Decodable {
    let url: String
    let params: Params?
    let priority: Int?
    let animationDuration: Int?
    let displayDuration: Int?
    let name: String?
}
