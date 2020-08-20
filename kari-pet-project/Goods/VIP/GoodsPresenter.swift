//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsDisplaying: ErrorDisplaying {
    func updateTableViewData()
    func getBlocksCount(blocksCount: Int)
    func getBlocksData(cards: [GoodsCard], recommended: [ProductsModel], related: [ProductsModel])
}

// MARK: - Declaration

final class GoodsPresenter {
    
    // MARK: Properties
    
    var view: GoodsDisplaying!
    
    // MARK: Private Properties
    
    private(set) var goodsCard: [GoodsCard] = []
    private(set) var recommendedProducts: [ProductsModel] = []
    private(set) var relatedProducts: [ProductsModel] = []
    
}

// MARK: - GoodsPresenting

extension GoodsPresenter: GoodsPresenting {
    
    
    func getBlocksData(blocks: [GoodsCard]) {
        goodsCard = blocks
    }
    
    func getRecommendedData(data: [ProductsModel]) {
        recommendedProducts = data
    }
    
    func getRelatedData(data: [ProductsModel]) {
        relatedProducts = data
    }
    
    func showAlert(with error: NetworkingError) {
        view.showAlert(with: error)
    }
    
    func sendBlocksData() {
        view.getBlocksCount(blocksCount: blocksCount)
        view.getBlocksData(cards: goodsCard, recommended: recommendedProducts, related: relatedProducts)
        view.updateTableViewData()
    }
    
    var blocksCount: Int {
        get {
            return [relatedProducts.isEmpty, recommendedProducts.isEmpty, goodsCard.isEmpty]
                .reduce(0) { $0 + ($1 ? 0 : 1) }
        }
    }
    
}
