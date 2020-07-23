//
//  RecomendedProducts.swift
//  kari-pet-project
//
//  Created by Admin on 21.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct GetRecomendedProducts: APIRequest {
    var httpMethod: HttpMethod { return .post }
    var url: String { return API.Main.recommendedProducts(for: API.alternative) }
    typealias Response = ProductsBlock
    
    var locationId: String
    var size: Int
    var page: Int
    var uniqueSizesIds: [String]
}
