//
//  GoodsConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum GoodsAssembler {
    
    static func configure(with view: GoodsVC) {
        let presenter = GoodsPresenter()
        let worker = GoodsWorker()
        let interactor = GoodsInteractor()
        let router = GoodsRouter()
        
        view.interactor = interactor
        worker.interactor = interactor
        presenter.view = view
        interactor.worker = worker
        interactor.presenter = presenter
        router.view = view
        view.router = router
    }
    
}
