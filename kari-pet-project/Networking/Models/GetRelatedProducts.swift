//
//  GetRelatedProducts.swift
//  kari-pet-project
//
//  Created by Admin on 22.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct GetRelatedProducts: APIRequest {
    var httpMethod: HttpMethod { return .post }
    var url: String { return API.Main.recommendedProducts(for: API.related) }
    typealias Response = ProductsBlock
    
    var locationId: String
    var size: Int
    var page: Int
    var uniqueSizesIds: [String]
}
