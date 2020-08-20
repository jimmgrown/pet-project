//
//  GoodsInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

// MARK: - GoodsInteractorProtocol

protocol GoodsInteracting: class {
    var uniqueSizesId: [[String]] { get }
    func handle(result: GetGoodsCard.Response?, error: NetworkingError?)
    func handleRecommended(result: GetRecomendedProducts.Response?, error: NetworkingError?)
    func handleRelated(result: GetRelatedProducts.Response?, error: NetworkingError?)
    func configureView(with vendoreCode: String)
    func notify()
}

// MARK: - Declaration

final class GoodsInteractor: GoodsInteracting {
    
    // MARK: Properties
    
    var presenter: GoodsPresenting!
    var worker: GoodsWorking!
    
    private(set) var uniqueSizesId: [[String]] = [[]]
    private(set) var goodsCardScreenData: GoodsCardScreenData?
    
}

// MARK: - Public API

extension GoodsInteractor {
    
    func configureView(with vendoreCode: String) {
        worker.getBlocksData(with: vendoreCode)
    }
    
    func handle(result: GetGoodsCard.Response?, error: NetworkingError?) {
        if let goodsCards = result {
            goodsCardScreenData?.goodsCard = goodsCards
            uniqueSizesId = goodsCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
        } else if let error = error {
            self.presenter.showAlert(with: error)
        }
    }
    
    func handleRecommended(result: GetRecomendedProducts.Response?, error: NetworkingError?) {
        if let products = result {
            goodsCardScreenData?.recommendedProducts = products.data.products
        } else if let error = error {
            self.presenter.showAlert(with: error)
        }
    }
    
    func handleRelated(result: GetRelatedProducts.Response?, error: NetworkingError?) {
        if let products = result {
            goodsCardScreenData?.relatedProducts = products.data.products
        } else if let error = error {
            self.presenter.showAlert(with: error)
        }
    }
    
    func notify() {
        if let blocks = goodsCardScreenData {
            presenter.getBlocksData(blocks: blocks)
        }
    }
    
}
