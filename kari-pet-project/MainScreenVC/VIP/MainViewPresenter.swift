//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol VCDelegate: class {
    var presenter: MainVCPresenter! { get set }
    var interactor: MainInteractor! { get set }
    func prepare()
    func updateData()
    func getResponse(with error: NetworkingError)
}

// MARK - MainPresenterProtocol

protocol MainPresenterProtocol: class {
    var vendorCode: String { get set }
    var blocks: [Block] { get set }
    var delegate: VCDelegate! { get set }
    var router: MainRouterProtocol! { set get }
    func blocksCount() -> Int
    func sendError(with error: NetworkingError)
}

// MARK: - Declaration

final class MainVCPresenter: MainPresenterProtocol {
    
    init(view: VCDelegate) {
        self.delegate = view
    }
    
    // MARK: Properties
    
    weak var delegate: VCDelegate!
    var router: MainRouterProtocol!
    var vendorCode: String = ""
    
    var blocks: [Block] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension MainVCPresenter {
    
    final func blocksCount() -> Int {
        return blocks.count
    }
    
    final func sendError(with error: NetworkingError) {
        delegate.getResponse(with: error)
    }
    
}
