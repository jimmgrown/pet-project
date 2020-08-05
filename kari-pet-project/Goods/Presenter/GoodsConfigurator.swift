//
//  GoodsConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsConfiguratorProtocol: class {
    func configure(with viewController: GoodsVCDelegate)
}

class GoodsConfigurator: GoodsConfiguratorProtocol {
    
    func configure(with viewController: GoodsVCDelegate) {
        let presenter = GoodsVCPresenter(view: viewController)
        let interactor = GoodsInteractor(presenter: presenter)
        let router = GoodsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
