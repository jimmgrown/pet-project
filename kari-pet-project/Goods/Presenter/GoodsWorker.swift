//
//  GoodsWorker.swift
//  kari-pet-project
//
//  Created by Admin on 06.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol GoodsWorkerProtocol: class {
    func getData(with vendoreCode: String)
}

// MARK: - Declaration

final class GoodsWorker: GoodsWorkerProtocol {
    
    weak var interactor: GoodsInteractorProtocol!
    let apiClient = APIClient()
    
    required init(interactor: GoodsInteractorProtocol) {
        self.interactor = interactor
    }
    
}

extension GoodsWorker {
    
    final func getData(with vendoreCode: String) {
        apiClient.send(GetGoodsCard(url: API.Main.goodsCardURL(for: vendoreCode))) { response in
            self.apiClient.handle(response: response) { result, error in
                self.interactor.handle(result: result, error: error)
            }
            
            let productsGroup = DispatchGroup()
            
            productsGroup.enter()
            self.apiClient.send(
                GetRecomendedProducts(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.interactor.uniqueSizesId[0]
                )
            ) { response in
                self.apiClient.handle(response: response) { result, error in
                    self.interactor.handleRecommended(result: result, error: error)
                    productsGroup.leave()
                }
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            
            productsGroup.enter()
            self.apiClient.send(
                GetRelatedProducts(
                    locationId: API.baseLocationId,
                    size: 5,
                    page: 1,
                    uniqueSizesIds: self.interactor.uniqueSizesId[0]
                )
            ) { response in
                self.apiClient.handle(response: response) { result, error in
                    self.interactor.handleRelated(result: result, error: error)
                    productsGroup.leave()
                }
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
            }
            
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.interactor.notify()
            }
        }
    }
    
}
