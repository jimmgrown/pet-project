//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenInteracting: class {
    func getData()
}

class MainScreenInteractor: MainScreenInteracting {

    weak var presenter: MainScreenPresenting!
    private let apiClient: APIClient = .init()
    
    init(presenter: MainScreenPresenting) {
        self.presenter = presenter
    }
    
}

extension MainScreenInteractor {
    
    func getData() {
        apiClient.send(GetMainScreenData()) { response in
            #warning("Это экстрактни в апи клиент, как в MVP")
            self.apiClient.handle(response: response) { result, error in
                if let result = result {
                    self.presenter.blocks = result.filter { $0.type != nil }.sorted(by: <)
                } else if let error = error {
                    self.presenter.delegate.showAlert(with: error)
                }
            }
        }
    }
    
}
