//
//  MainWorker.swift
//  kari-pet-project
//
//  Created by Admin on 06.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainWorkerProtocol: class {
    func getData()
}

final class MainWorker: MainWorkerProtocol {
    
    weak var interactor: MainInteractorProtocol!
    let apiClient = APIClient()
    
    required init(interactor: MainInteractorProtocol) {
        self.interactor = interactor
    }
    
}

// MARK: - Public API

extension MainWorker {
    
    final func getData() {
        apiClient.send(GetMainScreenData()) { response in
            self.apiClient.handle(response: response) { result, error in
                self.interactor.handle(result: result, error: error)
            }
        }
    }
    
}
