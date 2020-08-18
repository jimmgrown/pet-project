//
//  MainConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum MainScreenAssembler {
    
    static func configure(with viewController: MainScreenVC) {
        let presenter: MainScreenPresenting = MainScreenPresenter(view: viewController)
        let interactor: MainScreenInteracting = MainScreenInteractor(presenter: presenter)
        let router: MainScreenRouter = MainScreenRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
