//
//  GetGoodsCard.swift
//  kari-pet-project
//
//  Created by Admin on 14.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct GetGoodsCard: APIRequest {
    var httpBody: Data?
    typealias Response = [GoodsCard]
    var httpMethod: HttpMethod { return HttpMethod.get}
    var url: String { return API.Main.goodsCardURL(vendorCode: "01808050") }
}
