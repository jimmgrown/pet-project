//
//  Goods.swift
//  kari-pet-project
//
//  Created by Admin on 24.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum Goods {
    
    typealias Displaying = GoodsDisplaying
    typealias Interacting = GoodsInteracting
    typealias Router = GoodsRouter
    typealias Presenting = GoodsPresenting
    typealias Routing = GoodsRouting
    typealias DataStore = GoodsDataStore
    typealias DataPassing = GoodsDataPassing
    
}

extension Goods {
    
    enum GetBlocksDataAction {
        
        enum Request {
            
            struct Card: APIRequest {
                typealias Response = [GoodsCard]
                var httpMethod: HttpMethod { return HttpMethod.get}
                var url: String
            }
            
            struct Recommended: APIRequest {
                var httpMethod: HttpMethod { return .post }
                var url: String { return API.Main.recommendedProducts(for: API.alternative) }
                typealias Response = ProductsBlock
                
                var locationId: String
                var size: Int
                var page: Int
                var uniqueSizesIds: [String]
            }
            
            struct Related: APIRequest {
                var httpMethod: HttpMethod { return .post }
                var url: String { return API.Main.recommendedProducts(for: API.related) }
                typealias Response = ProductsBlock
                
                var locationId: String
                var size: Int
                var page: Int
                var uniqueSizesIds: [String]
            }
            
        }
        
        enum Response {
            
            struct Card {
                var data: Goods.GetBlocksDataAction.Request.Card.Response?
                var error: NetworkingError?
            }
            
            struct Recommended {
                var data: Goods.GetBlocksDataAction.Request.Recommended.Response?
                var error: NetworkingError?
            }
            
            struct Related {
                var data: Goods.GetBlocksDataAction.Request.Related.Response?
                var error: NetworkingError?
            }
        }
        
        struct ViewModel {
            var card: [GoodsCard]
            var recommended: [ProductsModel]
            var related: [ProductsModel]
            var blocksCount: Int
        }
        
    }
    
}
