//
//  Result.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Где констреинт Error-то?")
enum Result<T, E> {
    case success(T)
    case failure(E)
}
