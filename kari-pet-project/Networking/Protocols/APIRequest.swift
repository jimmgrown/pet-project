//
//  APIRequest.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//
#warning("Раз используешь енам для http методов, то в чем смысл здесь доставать rawValue? Тебе тогда придется делать то же самое каждый раз, когда ты хочешь указать недефолтный метод. Логичнее здесь еще работать с енамом, а rawValue извлекать уже в апи клиенте, там, где этот метод уже непосредственно используется")
protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var httpMethod: String { get }
    var url: String { get }
}

extension APIRequest {
    var httpMethod: String { return HttpMethod.get.rawValue }
    #warning("Дефолтный url - странное решение, не надо так")
    var url: String { return API.Main.mainScreenURL(client: API.client) }
}

#warning("Не стоит для такого экстрактить отдельный протокол, ты же не будешь переиспользовать это в нескольких местах. Просто указывай необходимый юрл в соответствующих объектах реквестов")
protocol APIGoodsCard: APIRequest {
    var url: String { get }
}

extension APIGoodsCard {
    var url: String { return API.Main.goodsCardURL() }
}
