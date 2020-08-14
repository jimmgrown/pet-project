//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsVCDelegate: class {
    var presenter: GoodsVCPresenter! { get set }
    var interactor: GoodsInteractor! { get set }
    func prepare()
    func updateData()
    func getResponse(with error: NetworkingError)
}

// MARK: - GoodsPresenterProtocol

protocol GoodsPresenterProtocol: class {
    var vendorCode: String { get set }
    var goodCards: [GoodsCard] { get set}
    var relatedProducts: [ProductsModel] { get set }
    var recommendedProducts: [ProductsModel] { get set }
    var delegate: GoodsVCDelegate! { get set }
    var router: GoodsRouterProtocol! { set get }
    func updateData()
    func blocksCount() -> Int
    func sendError(with error: NetworkingError)
}

// MARK: - Declaration

final class GoodsVCPresenter: GoodsPresenterProtocol {
    
    init(view: GoodsVCDelegate) {
        self.delegate = view
    }
    
    // MARK: Properties
    
    weak var delegate: GoodsVCDelegate!
    var router: GoodsRouterProtocol!
    var vendorCode: String = ""
    var relatedProducts: [ProductsModel] = []
    var recommendedProducts: [ProductsModel] = []
    
    var goodCards: [GoodsCard] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension GoodsVCPresenter {
    
    final func blocksCount() -> Int {
        var blocksCounter: Int = 0
        blocksCounter = relatedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = recommendedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = goodCards.count > 0 ? blocksCounter + 1 : blocksCounter
        return blocksCounter
    }
    
    final func sendError(with error: NetworkingError) {
        delegate.getResponse(with: error)
    }
    
    final func updateData() {
        delegate.updateData()
    }
    
}
