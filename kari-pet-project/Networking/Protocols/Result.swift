//
//  Result.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
