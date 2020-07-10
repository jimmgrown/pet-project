//
//  Result.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Зачем здесь паблик?")
public enum Result<T> {
    case success(T)
    case failure(Error)
}
