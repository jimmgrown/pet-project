//
//  getMainScreenData.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

// MARK: Types

struct GetMainScreenData: APIRequest {
    typealias Response = [Block]
    var httpMethod: HttpMethod { return HttpMethod.get }
    var url: String { return API.Main.mainScreenURL() }
}
