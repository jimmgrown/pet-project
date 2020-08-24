//
//  MainScreen.swift
//  kari-pet-project
//
//  Created by Admin on 21.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum MainScreen {
    
    typealias CellsDelegate = CategoriesCellDelegate & SliderCellDelegate &
        InformationCellDelegate & FindsCellDelegate & BrandsCellDelegate
    typealias Displaying = MainScreenDisplaying
    typealias Interacting = MainScreenInteracting
    typealias Router = MainScreenRouter
    typealias Presenting = MainScreenPresenting
    typealias Routing = MainScreenRouting
    
}

extension MainScreen {
    
    enum GetBlocksDataAction {
        
        struct Request: APIRequest {
            var httpBody: Data?
            typealias Response = [Block]
            var httpMethod: HttpMethod { return .get }
            var url: String { return API.Main.mainScreenURL() }
        }
        
        struct Response {
            var data: MainScreen.GetBlocksDataAction.Request.Response?
            var error: NetworkingError?
        }
        
        struct ViewModel {
            var blocks: [Block]
        }
        
    }
    
}
