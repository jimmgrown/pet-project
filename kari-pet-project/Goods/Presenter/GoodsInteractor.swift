//
//  GoodsInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol GoodsInteractorProtocol: class {
    func getData(with vendoreCode: String)
}

class GoodsInteractor: GoodsInteractorProtocol {
    
    weak var presenter: GoodsPresenterProtocol!
    let apiClient = APIClient()
    
    required init(presenter: GoodsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getData(with vendoreCode: String) {
        apiClient.send(GetGoodsCard(url: API.Main.goodsCardURL(for: vendoreCode))) { response in
            self.apiClient.handle(response: response) { result, error in
                if let goodCards = result {
                    self.presenter.goodCards = goodCards
                    self.presenter.uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
                } else if let error = error {
                    self.presenter.delegate.getResponse(with: error)
                }
            }
            
            let productsGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: productsGroup) {
                self.apiClient.send(
                    GetRecomendedProducts(
                        locationId: API.baseLocationId,
                        size: 5,
                        page: 1,
                        uniqueSizesIds: self.presenter.uniqueSizesId[0]
                    )
                ) { response in
                    self.apiClient.handle(response: response) { result, error in
                        if let products = result {
                            self.presenter.recommendedProducts = products.data.products
                        } else if let error = error {
                            self.presenter.delegate.getResponse(with: error)
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
                        uniqueSizesIds: self.presenter.uniqueSizesId[0]
                    )
                ) { response in
                    self.apiClient.handle(response: response) { result, error in
                        if let products = result {
                            self.presenter.relatedProducts = products.data.products
                        } else if let error = error {
                            self.presenter.delegate.getResponse(with: error)
                        }
                    }
                    //print(try? JSONSerialization.jsonObject(with: data!, options: []))
                }
            }
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.presenter.delegate.updateData()
            }
        }
    }
    
}
