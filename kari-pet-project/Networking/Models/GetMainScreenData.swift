//
//  getMainScreenData.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct GetMainScreenData: APIRequest {
    var httpBody: Data?
    typealias Response = [Block]
    var httpMethod: HttpMethod { return .get }
    var url: String { return API.Main.mainScreenURL() }
}
