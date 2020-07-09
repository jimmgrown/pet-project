//
//  DataContainer.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable>: Decodable {
    public let results: Results
}
