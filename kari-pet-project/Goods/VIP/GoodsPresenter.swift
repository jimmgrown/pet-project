//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsDisplaying: Displaying {
    var interactor: GoodsInteracting { get set }
    var router: GoodsRouter { get set }
    func updateData()
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class GoodsPresenter: GoodsPresenting {
    
    // MARK: Properties
    
    weak var view: GoodsDisplaying!
    var relatedProducts: [ProductsModel] = []
    var recommendedProducts: [ProductsModel] = []
    var goodCards: [GoodsCard] = []
    
    // MARK: Initialization
    
    init(view: GoodsDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension GoodsPresenter {
    
    var blocksCount: Int {
        get {
            return [relatedProducts.isEmpty, recommendedProducts.isEmpty, goodCards.isEmpty]
                .reduce(0) { $0 + ($1 ? 0 : 1) }
        }
    }
    
    func updateData() {
        view.updateData()
    }
    
}
