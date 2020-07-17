//
//  getMainScreenData.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Тут не нужна марка, но если была бы нужна, ты забыл дефис")
// MARK: Types

struct GetMainScreenData: APIRequest {
    typealias Response = [Block]
    #warning("Используй type inference по максимуму")
    var httpMethod: HttpMethod { return HttpMethod.get }
    var url: String { return API.Main.mainScreenURL() }
}
