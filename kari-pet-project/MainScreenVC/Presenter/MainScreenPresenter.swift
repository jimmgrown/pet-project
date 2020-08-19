//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenDisplaying: ErrorDisplaying {
    func updateTableViewData()
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Properties
    
    unowned var view: MainScreenDisplaying!
    var interactor: MainScreenInteracting!
    var router: MainScreenRouter!
    var vendorCode: String = ""
    
    var blocks: [Block] = [] {
        didSet {
            view.updateTableViewData()
        }
    }
    
}

// MARK: - Public API

extension MainScreenPresenter: MainScreenPresenting {
    
    func goToGoodsVC(with vendorCode: String) {
        router.goToGoodsVC(vendorCode: vendorCode)
    }

    func configureView() {
        self.interactor.getBlocksData()
    }
    
    func showAlert(with error: NetworkingError) {
        view.showAlert(with: error)
    }
    
}
