//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainInteractorProtocol: class {
    func getData()
}

class MainInteractor: MainInteractorProtocol {

    weak var presenter: MainPresenterProtocol!
    let apiClient = APIClient()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getData() {
        apiClient.send(GetMainScreenData()) { response in
            self.apiClient.handle(response: response) { result, error in
                if let result = result {
                    self.presenter.blocks = result.filter { $0.type != nil }.sorted(by: <)
                } else if let error = error {
                    self.presenter.delegate.getResponse(with: error)
                }
            }
        }
    }
    
}
