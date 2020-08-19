//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsDisplaying: ErrorDisplaying {
    var presenter: GoodsPresenting { get set }
    func updateData()
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class GoodsPresenter: GoodsPresenting {
    
    init(view: GoodsDisplaying) {
        self.view = view
    }
    
    // MARK: Properties
    
    unowned let view: GoodsDisplaying
    var interactor: GoodsInteracting!
    var router: GoodsRouter!
    var uniqueSizesId: [[String]] = [[]]
    var vendorCode: String = ""
    var relatedProducts: [ProductsModel] = []
    var recommendedProducts: [ProductsModel] = []
    var goodCards: [GoodsCard] = []
    
}

// MARK: - Public API

extension GoodsPresenter {
    
    var blocksCount: Int {
        get {
            return [relatedProducts.isEmpty, recommendedProducts.isEmpty, goodCards.isEmpty]
                .reduce(0) { $0 + ($1 ? 0 : 1) }
        }
    }
    
    func configureView(with vendorCode: String) {
        self.interactor.getBlocksData(with: vendorCode)
    }
    
}
