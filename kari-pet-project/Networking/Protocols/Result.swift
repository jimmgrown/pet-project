//
//  Result.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Пробел после // + марка тут не нужна")
#warning("Это нереюзабельный Result, я мб захочу какой-то другой енам ошибки использовать в какой-то ситуации, несвязанной с нетворкингом. Я уже писал, что нужен констреинт, а не конкретный тип/протокол")

//MARK: Types

enum Result<T> {
    case success(T)
    case failure(CustomError)
}
