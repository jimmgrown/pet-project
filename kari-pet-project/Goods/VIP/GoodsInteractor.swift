//
//  GoodsInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

// MARK: - GoodsInteractorProtocol

protocol GoodsInteractorProtocol: class {
    var uniqueSizesId: [[String]] { get set }
    func handle(result: GetGoodsCard.Response?, error: NetworkingError?)
    func handleRecommended(result: GetRecomendedProducts.Response?, error: NetworkingError?)
    func handleRelated(result: GetRelatedProducts.Response?, error: NetworkingError?)
    func configureView(with vendoreCode: String)
    func notify()
    func prepare(with vendorCode: String)
}

// MARK: - Declaration

final class GoodsInteractor: GoodsInteractorProtocol {
    
    weak var presenter: GoodsPresenterProtocol!
    var worker: GoodsWorkerProtocol!
    var uniqueSizesId: [[String]] = [[]]
    
    required init(presenter: GoodsPresenterProtocol) {
        self.presenter = presenter
    }
    
}

// MARK: - Public API

extension GoodsInteractor {
    
    final func configureView(with vendoreCode: String) {
        worker.getData(with: vendoreCode)
    }
    
    final func handle(result: GetGoodsCard.Response?, error: NetworkingError?) {
        if let goodCards = result {
            presenter.goodCards = goodCards
            uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
        } else if let error = error {
            self.presenter.sendError(with: error)
        }
    }
    
    final func handleRecommended(result: GetRecomendedProducts.Response?, error: NetworkingError?) {
        if let products = result {
            self.presenter.recommendedProducts = products.data.products
        } else if let error = error {
            self.presenter.sendError(with: error)
        }
    }
    
    final func handleRelated(result: GetRelatedProducts.Response?, error: NetworkingError?) {
        if let products = result {
            self.presenter.relatedProducts = products.data.products
        } else if let error = error {
            self.presenter.sendError(with: error)
        }
    }
    
    final func notify() {
        self.presenter.updateData()
    }
    
    final func prepare(with vendorCode: String) {
        presenter.vendorCode = vendorCode
        presenter.router.show()
    }
    
}
