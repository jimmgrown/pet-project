//
//  GoodsConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum GoodsAssembler {
    
    static func configure(with viewController: GoodsVC) {
        let presenter = GoodsPresenter()
        let interactor = GoodsInteractor()
        let router = GoodsRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
    }
    
}
