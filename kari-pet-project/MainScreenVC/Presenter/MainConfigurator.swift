//
//  MainConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: VCDelegate)
}

class MainConfigurator: MainConfiguratorProtocol {
    
    func configure(with viewController: VCDelegate) {
        let presenter = MainVCPresenter(view: viewController)
        let interactor = MainInteractor(presenter: presenter)
        let worker = MainWorker(interactor: interactor)
        let router = MainRouter(viewController: viewController)
        
        viewController.presenter = presenter
        interactor.worker = worker
        viewController.interactor = interactor
        presenter.router = router
        
    }
}
