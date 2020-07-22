//
//  HttpBody.swift
//  kari-pet-project
//
//  Created by Admin on 21.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct GetRecomendedProducts: APIRequest {
    var httpBody: Data?
    typealias Response = ProductsBlock
    var httpMethod: HttpMethod { return .post }
    var url: String { return API.Main.recommendedProducts() }
}
