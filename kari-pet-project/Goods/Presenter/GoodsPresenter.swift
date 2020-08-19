//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsDisplaying: ErrorDisplaying {
    func updateTableViewData()
}

// MARK: - Declaration

final class GoodsPresenter {
    
    // MARK: Properties
    
    var view: GoodsDisplaying!
    var interactor: GoodsInteracting!
    var router: GoodsRouter!
    
    private(set) var uniqueSizesId: [[String]] = [[]]
    private(set) var relatedProducts: [ProductsModel] = []
    private(set) var recommendedProducts: [ProductsModel] = []
    private(set) var goodCards: [GoodsCard] = []
    
}

// MARK: - Public API

extension GoodsPresenter: GoodsPresenting {
    
    var blocksCount: Int {
        get {
            return [relatedProducts.isEmpty, recommendedProducts.isEmpty, goodCards.isEmpty]
                .reduce(0) { $0 + ($1 ? 0 : 1) }
        }
    }
    
    func goToGoodsVC(with vendorCode: String) {
        router.goToGoodsVC(vendorCode: vendorCode)
    }
    
    func configureView(with vendorCode: String) {
        self.interactor.getBlocksData(with: vendorCode)
    }
    
    func showAlert(with error: NetworkingError) {
        view.showAlert(with: error)
    }
    
    func updateTableViewData() {
        view.updateTableViewData()
    }
    
    func getGoodsCardData(goodCards: GetGoodsCard.Response, uniqueSizesId: [[String]]) {
        self.goodCards = goodCards
        self.uniqueSizesId = uniqueSizesId
    }
    
    func getProductsBlocksData(productsBlocks: (recommended: [ProductsModel], related: [ProductsModel])) {
        self.recommendedProducts = productsBlocks.recommended
        self.relatedProducts = productsBlocks.related
    }
    
}
