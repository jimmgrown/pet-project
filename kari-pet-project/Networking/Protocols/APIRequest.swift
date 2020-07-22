//
//  APIRequest.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var httpMethod: HttpMethod { get }
    var url: String { get }
    #warning("Я же задавал тебе вопрос, зачем ты сюда это поле засунул? Структура, конформящаяся под APIRequest - это уже то самое body, которое тебе необходимо")
    var httpBody: Data? { get }
}
