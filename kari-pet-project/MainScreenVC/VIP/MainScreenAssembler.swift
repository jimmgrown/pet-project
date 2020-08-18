//
//  MainConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum MainScreenAssembler {
    
    static func configure(with view: MainScreenVC) {
        let presenter: MainScreenPresenting = MainScreenPresenter(view: view)
        let worker: MainScreenWorking = MainScreenWorker(interactor: view.interactor)
        
        view.interactor.worker = worker
        view.interactor.presenter = presenter
        
    }
}
