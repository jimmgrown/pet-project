//
//  GoodsViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsVCDelegate: class {
    var presenter: GoodsVCPresenter! { get set }
    func updateData()
    func getResponse(with error: NetworkingError)
}

protocol GoodsPresenterProtocol: class {
    var goodCards: [GoodsCard] { get set}
    var relatedProducts: [ProductsModel] { get set }
    var recommendedProducts: [ProductsModel] { get set }
    var uniqueSizesId: [[String]] { get set }
    var delegate: GoodsVCDelegate! { get set }
    var router: GoodsRouterProtocol! { set get }
    func configureView(with vendoreCode: String)
    func blocksCount() -> Int
}

// MARK: - Declaration

final class GoodsVCPresenter: GoodsPresenterProtocol {
    
    init(view: GoodsVCDelegate) {
        self.delegate = view
    }
    
    // MARK: Properties
    
    weak var delegate: GoodsVCDelegate!
    var interactor: GoodsInteractorProtocol!
    var router: GoodsRouterProtocol!
    var uniqueSizesId: [[String]] = [[]]
    
    var relatedProducts: [ProductsModel] = []  {
        didSet {
            delegate.updateData()
        }
    }
    
    var recommendedProducts: [ProductsModel] = []   {
        didSet {
            delegate.updateData()
        }
    }
    
    var goodCards: [GoodsCard] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension GoodsVCPresenter {
    
    func configureView(with vendoreCode: String) {
        self.interactor.getData(with: vendoreCode)
    }
    
    final func blocksCount() -> Int {
        var blocksCounter: Int = 0
        blocksCounter = relatedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = recommendedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = goodCards.count > 0 ? blocksCounter + 1 : blocksCounter
        return blocksCounter
    }
    
}
