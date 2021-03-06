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
}
