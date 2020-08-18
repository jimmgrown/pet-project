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

#warning("final")
class MainScreenInteractor: MainScreenInteracting {

    weak var presenter: MainScreenPresenting!
    #warning("private")
    let apiClient = APIClient()
    
    #warning("Зачем required?")
    required init(presenter: MainScreenPresenting) {
        self.presenter = presenter
    }
    
    #warning("Почему это не в экстеншне?")
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
