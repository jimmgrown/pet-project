//
//  APIResponse.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Зачем здесь паблик?")
#warning("Зачем еще одна обертка над контейнером?")
public struct APIResponse<Response: Decodable>: Decodable {
    public let status: String?
    public let message: String?
    public let data: DataContainer<Response>?
}
