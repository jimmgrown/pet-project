//
//  Params.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Params: Decodable {
    let locationId: String?
    let filters: Filters
    let size: Int
    let page: Int
}
