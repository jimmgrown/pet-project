//
//  GoodsInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

// MARK: - GoodsInteractorProtocol

protocol GoodsInteracting: class {
    var worker: GoodsWorking! { get set }
    var presenter: GoodsPresenting! { get set }
    var uniqueSizesId: [[String]] { get set }
    
    func handle(result: GetGoodsCard.Response?, error: NetworkingError?)
    func handleRecommended(result: GetRecomendedProducts.Response?, error: NetworkingError?)
    func handleRelated(result: GetRelatedProducts.Response?, error: NetworkingError?)
    func configureView(with vendoreCode: String)
    func notify()
}

// MARK: - Declaration

final class GoodsInteractor: GoodsInteracting {
    
    // MARK: Private properties
    
    private weak var view: GoodsDisplaying!
    
    // MARK: Properties
    
    var presenter: GoodsPresenting!
    var worker: GoodsWorking!
    
    var uniqueSizesId: [[String]] = [[]]
    
    init(view: GoodsDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension GoodsInteractor {
    
    func configureView(with vendoreCode: String) {
        worker.getBlocksData(with: vendoreCode)
    }
    
    func handle(result: GetGoodsCard.Response?, error: NetworkingError?) {
        if let goodCards = result {
            presenter.goodCards = goodCards
            uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
        } else if let error = error {
            self.presenter.view.showAlert(with: error)
        }
    }
    
    func handleRecommended(result: GetRecomendedProducts.Response?, error: NetworkingError?) {
        if let products = result {
            self.presenter.recommendedProducts = products.data.products
        } else if let error = error {
            self.presenter.view.showAlert(with: error)
        }
    }
    
    func handleRelated(result: GetRelatedProducts.Response?, error: NetworkingError?) {
        if let products = result {
            self.presenter.relatedProducts = products.data.products
        } else if let error = error {
            self.presenter.view.showAlert(with: error)
        }
    }
    
    final func notify() {
        self.presenter.view.updateData()
    }
    
    
}
