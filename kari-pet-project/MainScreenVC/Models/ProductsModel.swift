//
//  ProductsModel.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct ProductsModel: Decodable {
    //let breadCrumbs: [BreadCrumbs]
    //let tags: [String]
    //let articul: String
    let preview: String
    let title: String
    let withVideo: Bool
    //let collection: CollectionField
    let price: Price
    let saleCount: Int
    let brand: Brand
    let colors: [Colors]?
    //let isNew: Bool
    let rate: Rate?
    //let withDiscount: Bool
}
