//
//  GetGoodsCard.swift
//  kari-pet-project
//
//  Created by Admin on 14.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Тут не нужна марка, но если была бы нужна, ты забыл дефис")
// MARK: Types

struct GetGoodsCard: APIRequest {
    typealias Response = [GoodsCard]
    var httpMethod: HttpMethod { return HttpMethod.get}
    #warning("В английском нет слова articul, должен быть vendorCode. Если есть сомнения в нейминге, спрашивай у меня. Не смотри на нейминг в апишке сервера, в той компании не самые компетентные люди работают")
    var url: String { return API.Main.goodsCardURL(articul: "01808050") }
}
