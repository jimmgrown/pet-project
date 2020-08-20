//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenInteracting: class {
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?)
    func configureView()
}

final class MainScreenInteractor {
    
    // MARK: Properties
    
    var presenter: MainScreenPresenting!
    var worker: MainScreenWorking!
    
}

// MARK: - MainScreenInteracting

extension MainScreenInteractor: MainScreenInteracting {
    
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?) {
        if let result = result {
            let blocks = result.filter { $0.type != nil }.sorted(by: <)
            self.presenter.getBlocksData(blocks: blocks)
        } else if let error = error {
            self.presenter.showAlert(with: error)
        }
    }
    
    func configureView() {
        worker.getBlocksData()
    }
    
}
