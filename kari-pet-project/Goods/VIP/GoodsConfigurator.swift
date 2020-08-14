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

final class GoodsConfigurator: GoodsConfiguratorProtocol {
    
    final func configure(with viewController: GoodsVCDelegate) {
        let presenter = GoodsVCPresenter(view: viewController)
        let interactor = GoodsInteractor(presenter: presenter)
        let worker = GoodsWorker(interactor: interactor)
        let router = GoodsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        interactor.worker = worker
        viewController.interactor = interactor
        presenter.router = router
    }
    
}
