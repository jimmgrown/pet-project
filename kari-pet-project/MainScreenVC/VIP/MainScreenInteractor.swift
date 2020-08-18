//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenInteracting: class {
    var worker: MainScreenWorking! { get set }
    var presenter: MainScreenPresenting! { get set }
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?)
    func configureView()
}

final class MainScreenInteractor: MainScreenInteracting {

    // MARK: Private properties
    
    private weak var view: MainScreenDisplaying!
    
    // MARK: Properties
    
    var presenter: MainScreenPresenting!
    var worker: MainScreenWorking!

    init(view: MainScreenDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension MainScreenInteractor {
    
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?) {
        if let result = result {
            self.presenter.blocks = result.filter { $0.type != nil }.sorted(by: <)
        } else if let error = error {
            self.presenter.view.showAlert(with: error)
        }
    }
    
    func configureView() {
        worker.getBlocksData()
    }
    
}
