//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenDataStore: class {
    var vendorCode: String? { get }
    func setDataStore(with vendorCode: String)
}

protocol MainScreenPresenting {
    func handle(response: MainScreen.GetBlocksDataAction.Response)
}

final class MainScreenInteractor {
    
    // MARK: Private properties
    
    private let apiClient: APIClient = .init()
    
    // MARK: Properties
    
    var presenter: MainScreen.Presenting!
    private(set) var vendorCode: String?
}

// MARK: - MainScreenInteracting

extension MainScreenInteractor: MainScreen.Interacting {
    
    func configureView(_ request: MainScreen.GetBlocksDataAction.Request) {
        apiClient.send(request) { result, error in
            self.presenter.handle(response: MainScreen.GetBlocksDataAction.Response(data: result, error: error))
        }
    }
    
}

extension MainScreenInteractor: MainScreenDataStore {
    
    func setDataStore(with vendorCode: String) {
        self.vendorCode = vendorCode
    }
    
}
