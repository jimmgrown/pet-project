//
//  APIRequest.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var httpMethod: String { get }
    var url: String { get }
}

extension APIRequest {
    var httpMethod: String { return HttpMethod.get.rawValue }
    var url: String { return API.Main.mainScreenURL(client: API.client) }
}

protocol APIGoodsCard: APIRequest {
    var url: String { get }
}

extension APIGoodsCard {
    var url: String { return API.Main.goodsCardURL() }
}
