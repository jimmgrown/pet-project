//
//  MainConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum MainScreenAssembler {
    
    static func configure(with viewController: MainScreenVC) {
        let presenter = MainScreenPresenter()
        let interactor = MainScreenInteractor()
        let router = MainScreenRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
    }
    
}
