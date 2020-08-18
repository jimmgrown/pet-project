//
//  MainWorker.swift
//  kari-pet-project
//
//  Created by Admin on 06.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenWorking: class {
    func getBlocksData()
}

final class MainScreenWorker: MainScreenWorking {
    
    private weak var interactor: MainScreenInteracting!
    private let apiClient: APIClient = .init()
    
    init(interactor: MainScreenInteracting) {
        self.interactor = interactor
    }
    
}

// MARK: - Public API

extension MainScreenWorker {
    
    func getBlocksData() {
        apiClient.send(GetMainScreenData()) { result, error in
            self.interactor.handle(result: result, error: error)
        }
    }
    
}
