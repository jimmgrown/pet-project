//
//  DataContainer.swift
//  kari-pet-project
//
//  Created by Admin on 09.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

#warning("Зачем здесь паблик?")
#warning("Множественное число в названии типа - плохая идея, Results лучше заменить на Data. Если вдруг в момент использования такого дженерика понадобится тип Data из Foundation, к нему можно будет обратиться явным образом через Foundation.Data")
#warning("Почему у тебя здесь находится поле results? В json приходит поле с другим названием, поэтому у тебя не раздекодится")
public struct DataContainer<Results: Decodable>: Decodable {
    public let results: Results
}
