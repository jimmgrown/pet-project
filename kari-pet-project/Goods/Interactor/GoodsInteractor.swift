//
//  GoodsInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol GoodsPresenting: class {
    func handle(response: Goods.GetBlocksDataAction.Response.Card)
    func handleRecommended(response: Goods.GetBlocksDataAction.Response.Recommended)
    func handleRelated(response: Goods.GetBlocksDataAction.Response.Related)
    func sendBlocksData()
}

protocol GoodsDataStore: class {
    var vendorCode: String? { get }
    func setDataStore(with vendorCode: String)
}

// MARK: - Declaration

final class GoodsInteractor {
    
    // MARK: Properties
    
    var presenter: Goods.Presenting!
    
    // MARK: Private properties
    
    private let apiClient: APIClient = .init()
    private(set) var uniqueSizesId: [[String]] = [[]]
    private(set) var vendorCode: String?
    
}

// MARK: - Public API

extension GoodsInteractor: Goods.Interacting {
    
    func setDataStore(with vendorCode: String) {
        self.vendorCode = vendorCode
    }
    
    
    func configureView(_ request: Goods.GetBlocksDataAction.Request.Card) {
        apiClient.send(request) { result, error in
            
            if let goodsCards = result {
                self.uniqueSizesId =  goodsCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
            } 
            
            self.presenter.handle(response: Goods.GetBlocksDataAction.Response.Card(data: result, error: error))
            
            let productsGroup = DispatchGroup()
            
            productsGroup.enter()
            self.apiClient.send(
                Goods.GetBlocksDataAction.Request.Recommended(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.uniqueSizesId[0] 
                )
            ) { result, error in
                self.presenter.handleRecommended(
                    response: Goods.GetBlocksDataAction.Response.Recommended(data: result, error: error)
                )
                productsGroup.leave()
                
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            productsGroup.enter()
            self.apiClient.send(
                Goods.GetBlocksDataAction.Request.Related(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.uniqueSizesId[0]
                )
            ) { result, error in
                self.presenter.handleRelated(
                    response: Goods.GetBlocksDataAction.Response.Related(data: result, error: error)
                )
                productsGroup.leave()
                
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.presenter.sendBlocksData()
            }
        }
    }
    
}
