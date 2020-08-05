//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol GoodsVCDelegate {
    func updateData()
    func getResponse(with error: NetworkingError)
}

protocol GoodsPresenter {
    func getData(for vendoreCode: String)
    func blocksCount() -> Int
}

// MARK: - Declaration

final class GoodsVCPresenter: GoodsPresenter {
    
    // MARK: Private properties
    
    private let apiClient = APIClient()
    
    // MARK: Properties
    
    var delegate: GoodsVCDelegate!
    var uniqueSizesId: [[String]] = [[]]
    
    var relatedProducts: [ProductsModel] = []  {
        didSet {
            delegate.updateData()
        }
    }
    
    var recommendedProducts: [ProductsModel] = []   {
        didSet {
            delegate.updateData()
        }
    }
    
    var goodCards: [GoodsCard] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension GoodsVCPresenter {
    
    final func getData(for vendoreCode: String) {
        apiClient.send(GetGoodsCard(url: API.Main.goodsCardURL(for: vendoreCode))) { response in
            self.apiClient.handle(response: response) { result, error in
                if let goodCards = result {
                    self.goodCards = goodCards
                    self.uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
                } else if let error = error {
                    self.delegate.getResponse(with: error)
                }
            }
            
            let productsGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: productsGroup) {
                self.apiClient.send(
                    GetRecomendedProducts(
                        locationId: API.baseLocationId,
                        size: 5,
                        page: 1,
                        uniqueSizesIds: self.uniqueSizesId[0]
                    )
                ) { response in
                        self.apiClient.handle(response: response) { result, error in
                            if let products = result {
                                self.recommendedProducts = products.data.products
                            } else if let error = error {
                                self.delegate.getResponse(with: error)
                            }
                        }
                    //print(try? JSONSerialization.jsonObject(with: data!, options: []))
                }
            }
            
            DispatchQueue.global(qos: .userInitiated).async(group: productsGroup) {
                self.apiClient.send(
                    GetRelatedProducts(
                        locationId: API.baseLocationId,
                        size: 5,
                        page: 1,
                        uniqueSizesIds: self.uniqueSizesId[0]
                    )
                ) { response in
                        self.apiClient.handle(response: response) { result, error in
                            if let products = result {
                                self.relatedProducts = products.data.products
                            } else if let error = error {
                                self.delegate.getResponse(with: error)
                            }
                        }
                    //print(try? JSONSerialization.jsonObject(with: data!, options: []))
                }
            }
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.delegate.updateData()
            }
        }
    }
    
    final func blocksCount() -> Int {
        var blocksCounter: Int = 0
        blocksCounter = relatedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = recommendedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = goodCards.count > 0 ? blocksCounter + 1 : blocksCounter
        return blocksCounter
    }
    
}
