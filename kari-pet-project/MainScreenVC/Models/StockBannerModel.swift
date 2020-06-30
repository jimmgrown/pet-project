//
//  StockBannerModel.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct StockBannerModel: Decodable {
    let bannerId: String
    let name: String
    let priority: Int
    let image: String
    let action: Action
}
