//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol GoodsDisplaying: Displaying {
    func updateGoodsData()
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class GoodsPresenter {
    
    // MARK: Private properties
    
    private let apiClient: APIClient = .init()
    private unowned let view: GoodsDisplaying
    private var uniqueSizesId: [[String]] = [[]]
    private(set) var relatedProducts: [ProductsModel] = []
    private(set) var recommendedProducts: [ProductsModel] = []
    private(set) var goodCards: [GoodsCard] = []
    
    // MARK: Initialization
    
    init(view: GoodsDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension GoodsPresenter: GoodsPresenting {
    
    var blocksCount: Int {
        return [relatedProducts.isEmpty, recommendedProducts.isEmpty, goodCards.isEmpty]
            .reduce(0) { $0 + ($1 ? 0 : 1) }
    }
    
    func getBlocksData(for vendorCode: String) {
        apiClient.send(GetGoodsCard(url: API.Main.goodsCardURL(for: vendorCode))) { result, error in
            if let goodCards = result {
                self.goodCards = goodCards
                self.uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
            } else if let error = error {
                self.view.showAlert(with: error)
            }
            
            
            let productsGroup = DispatchGroup()
            
            productsGroup.enter()
            self.apiClient.send(
                GetRecomendedProducts(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.uniqueSizesId[0]
                )
            ) { result, error in
                if let products = result {
                    self.recommendedProducts = products.data.products
                } else if let error = error {
                    self.view.showAlert(with: error)
                }
                productsGroup.leave()
                
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            
            productsGroup.enter()
            self.apiClient.send(
                GetRelatedProducts(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.uniqueSizesId[0]
                )
            ) { result, error in
                if let products = result {
                    self.relatedProducts = products.data.products
                } else if let error = error {
                    self.view.showAlert(with: error)
                }
                productsGroup.leave()
                
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.view.updateGoodsData()
            }
        }
    }
    
}
