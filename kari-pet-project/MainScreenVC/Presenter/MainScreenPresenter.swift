//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenDisplaying: Displaying {
    var presenter: MainScreenPresenting { get set }
    func updateData()
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Properties
    
    unowned let view: MainScreenDisplaying
    var interactor: MainScreenInteracting!
    var router: MainScreenRouter!
    var vendorCode: String = ""
    
    var blocks: [Block] = [] {
        didSet {
            view.updateData()
        }
    }
    
    // MARK: Initialization
    
    init(view: MainScreenDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension MainScreenPresenter: MainScreenPresenting {

    func configureView() {
        self.interactor.getBlocksData()
    }
    
}
