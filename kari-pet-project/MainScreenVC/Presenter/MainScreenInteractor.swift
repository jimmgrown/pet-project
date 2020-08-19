//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenInteracting: class {
    func getBlocksData()
}


final class MainScreenInteractor {

    var presenter: MainScreenPresenting!
    private let apiClient: APIClient = .init()
    
}

extension MainScreenInteractor: MainScreenInteracting {
    
    func getBlocksData() {
        apiClient.send(GetMainScreenData()) { result, error in
            if let result = result {
                let blocks = result.filter { $0.type != nil }.sorted(by: <)
                self.presenter.getBlocksData(blocks: blocks)
            } else if let error = error {
                self.presenter.showAlert(with: error)
            }
        }
    }
    
}
