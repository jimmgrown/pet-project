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
    func updateData()
    func getResponse(with error: NetworkingError)
}

protocol MainPresenterProtocol: class {
    var blocks: [Block] { get set }
    var delegate: VCDelegate! { get set }
    var router: MainRouterProtocol! { set get }
    func configureView()
    func blocksCount() -> Int
}

// MARK: - Declaration

class MainVCPresenter: MainPresenterProtocol {
    
    init(view: VCDelegate) {
        self.delegate = view
    }
    
    // MARK: Properties
    
    weak var delegate: VCDelegate!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    var blocks: [Block] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension MainVCPresenter {
    
    final func configureView() {
        self.interactor.getData()
    }
    
    final func blocksCount() -> Int {
        return blocks.count
    }
    
}
