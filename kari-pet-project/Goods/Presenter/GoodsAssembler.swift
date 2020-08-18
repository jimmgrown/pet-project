//
//  GoodsConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum GoodsAssembler {
    
    static func configure(with viewController: GoodsVC) {
        let presenter = GoodsPresenter(view: viewController)
        let interactor = GoodsInteractor(presenter: presenter)
        let router = GoodsRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
