//
//  GoodsInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol GoodsInteracting: class {
    func getBlocksData(with vendoreCode: String)
}

final class GoodsInteractor: GoodsInteracting {
    
    weak var presenter: GoodsPresenting!
    let apiClient: APIClient = .init()
    
    init(presenter: GoodsPresenting) {
        self.presenter = presenter
    }
    
    func getBlocksData(with vendorCode: String) {
        apiClient.send(GetGoodsCard(url: API.Main.goodsCardURL(for: vendorCode))) { result, error in
            if let goodCards = result {
                self.presenter.goodCards = goodCards
                self.presenter.uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
            } else if let error = error {
                self.presenter.view.showAlert(with: error)
            }
            
            let productsGroup = DispatchGroup()
            
            productsGroup.enter()
            self.apiClient.send(
                GetRecomendedProducts(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.presenter.uniqueSizesId[0]
                )
            ) { result, error in
                if let products = result {
                    self.presenter.recommendedProducts = products.data.products
                } else if let error = error {
                    self.presenter.view.showAlert(with: error)
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
                    uniqueSizesIds: self.presenter.uniqueSizesId[0]
                )
            ) { result, error in
                if let products = result {
                    self.presenter.relatedProducts = products.data.products
                } else if let error = error {
                    self.presenter.view.showAlert(with: error)
                }
                productsGroup.leave()
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.presenter.view.updateData()
            }
            
        }
    }
    
}
