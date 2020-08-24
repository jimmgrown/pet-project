//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

// MARK: - Declaration

protocol GoodsDisplaying: ErrorDisplaying {
    func updateTableViewData()
    func updateUI(viewModel: Goods.GetBlocksDataAction.ViewModel)
}

final class GoodsPresenter {
    
    // MARK: Properties
    
    var view: GoodsDisplaying!
    
    // MARK: Private Properties
    
    private(set) var viewModel = Goods.GetBlocksDataAction.ViewModel(
        card: [],
        recommended: [],
        related: [],
        blocksCount: 0
    )
    
}

// MARK: - GoodsPresenting

extension GoodsPresenter: GoodsPresenting {

    func sendBlocksData() {
        viewModel.blocksCount = blocksCount
        view.updateUI(viewModel: viewModel)
        view.updateTableViewData()
    }
    
    var blocksCount: Int {
        get {
            return [
                self.viewModel.related.isEmpty,
                self.viewModel.recommended.isEmpty,
                self.viewModel.card.isEmpty
            ].reduce(0) { $0 + ($1 ? 0 : 1) }
        }
    }
    
    func handle(response: Goods.GetBlocksDataAction.Response.Card) {
        if let goodsCards = response.data {
            self.viewModel.card = goodsCards
        } else if let error = response.error {
            self.view.showAlert(with: error)
        }
    }
    
    func handleRecommended(response: Goods.GetBlocksDataAction.Response.Recommended) {
        if let products = response.data {
            self.viewModel.recommended = products.data.products
        } else if let error = response.error {
            self.view.showAlert(with: error)
        }
    }
    
    func handleRelated(response: Goods.GetBlocksDataAction.Response.Related) {
        if let products = response.data {
            self.viewModel.related = products.data.products
        } else if let error = response.error {
            self.view.showAlert(with: error)
        }
    }
    
}
