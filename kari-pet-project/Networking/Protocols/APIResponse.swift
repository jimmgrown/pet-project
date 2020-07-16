//
//  APIResponse.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

//MARK: Types

struct APIResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: Response?
}
