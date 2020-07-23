//
//  CategoriesTree.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct CategoriesTree: Decodable {
    let uniqueId: Int
    let name: String
    let machineName: String
    let retailGroup: [String]
    let importId: String
    let image: String?
    let mainCategory: Bool?
    let level: Int
    let saleFlag: Bool
    let newFlag: Bool
    let priority: Int
    let parent: String?
    let hex: String?
    let mobileImage: String?
    let allowForMobile: Bool?
}
