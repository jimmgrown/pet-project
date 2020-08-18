//
//  GoodsConfigurator.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

enum GoodsAssembler {
    
    static func configure(with view: GoodsVC) {
        let presenter: GoodsPresenting = GoodsPresenter(view: view)
        let worker: GoodsWorking = GoodsWorker(interactor: view.interactor)
        
        view.interactor.worker = worker
        view.interactor.presenter = presenter
    }
    
}
