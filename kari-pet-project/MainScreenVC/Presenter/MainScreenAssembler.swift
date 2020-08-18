//
//  MainConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenAssembling: class {
    func configure(with viewController: MainScreenDisplaying)
}

class MainScreenAssembler: MainScreenAssembling {
    
    func configure(with viewController: MainScreenDisplaying) {
        let presenter: MainScreenPresenting = MainScreenPresenter(view: viewController)
        let interactor: MainScreenInteracting = MainScreenInteractor(presenter: presenter)
        let router: MainScreenRouting = MainScreenRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
