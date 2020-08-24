//
//  GoodsConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum GoodsConfigurator {
    
    static func configure(with view: GoodsVC) {
        let presenter = GoodsPresenter()
        let interactor = GoodsInteractor()
        let router = GoodsRouter()
        
        view.interactor = interactor
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        view.router = router
        router.dataStore = interactor
    }
    
}
