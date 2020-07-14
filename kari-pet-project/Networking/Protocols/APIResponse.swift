//
//  APIResponse.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Тут надо все поля получать, тебе ведь ошибки тоже надо будет обрабатывать в какой-то момент")
struct APIResponse<Response: Decodable>: Decodable {
    //public let status: String?
    //public let message: String?
    #warning("Почему тут public остался?")
    public let data: Response?
}
