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

#warning("final")
#warning("Конформанс не на месте")
class MainScreenInteractor: MainScreenInteracting {

    #warning("Я уже говорил, weak вместе с ! не имеет никакого смысла. Используй либо unowned, либо ?. Во всем проекте проследи за этим")
    private weak var presenter: MainScreenPresenting!
    private let apiClient: APIClient = .init()
    
    init(presenter: MainScreenPresenting) {
        self.presenter = presenter
    }
    
}

extension MainScreenInteractor {
    
    func getBlocksData() {
        apiClient.send(GetMainScreenData()) { result, error in
            if let result = result {
                self.presenter.blocks = result.filter { $0.type != nil }.sorted(by: <)
            } else if let error = error {
                self.presenter.view.showAlert(with: error)
            }
        }
    }
    
}
