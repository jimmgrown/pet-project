//
//  APIResponse.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Пробел после // + марка тут не нужна")

//MARK: Types

#warning("Почему не отлавливаешь сообщение об ошибке? Вдруг его экранировать придется")
struct APIResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: Response?
}
