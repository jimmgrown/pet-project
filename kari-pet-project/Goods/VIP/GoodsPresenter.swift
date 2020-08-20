//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

struct GoodsCardScreenData {
    var goodsCard: GetGoodsCard.Response
    var recommendedProducts: [ProductsModel]
    var relatedProducts: [ProductsModel]
}

protocol GoodsDisplaying: ErrorDisplaying {
    func updateTableViewData()
    func getBlocksCount(blocksCount: Int)
    func getBlocksData(blocks: GoodsCardScreenData)
}

// MARK: - Declaration

final class GoodsPresenter {
    
    // MARK: Properties
    
    var view: GoodsDisplaying!
    
    private(set) var blocks: GoodsCardScreenData? {
        didSet {
            view.getBlocksCount(blocksCount: blocksCount)
            if let blocks = blocks {
                view.getBlocksData(blocks: blocks)
            }
            view.updateTableViewData()
        }
    }
    
    // MARK: Initialization
    
}

// MARK: - Public API

extension GoodsPresenter: GoodsPresenting {
    
    
    func getBlocksData(blocks: GoodsCardScreenData) {
        self.blocks = blocks
    }
    
    
    func showAlert(with error: NetworkingError) {
        view.showAlert(with: error)
    }
    
    var blocksCount: Int {
        get {
            if let blocks = blocks {
                return [blocks.relatedProducts.isEmpty, blocks.recommendedProducts.isEmpty, blocks.goodsCard.isEmpty]
                    .reduce(0) { $0 + ($1 ? 0 : 1) }
            } else {
                return 0
            }
        }
    }
    
}
