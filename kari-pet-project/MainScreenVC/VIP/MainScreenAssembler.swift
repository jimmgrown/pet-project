//
//  MainConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum MainScreenAssembler {
    
    static func configure(with view: MainScreenVC) {
        let presenter = MainScreenPresenter()
        let worker = MainScreenWorker()
        let interactor = MainScreenInteractor()
        let router = MainScreenRouter()
        
        view.interactor = interactor
        worker.interactor = interactor
        presenter.view = view
        interactor.worker = worker
        interactor.presenter = presenter
        router.view = view
        view.router = router
        
    }
}
