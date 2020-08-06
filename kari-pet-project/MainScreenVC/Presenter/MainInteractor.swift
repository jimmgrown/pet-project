//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainInteractorProtocol: class {
    var worker: MainWorkerProtocol! { get set }
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?)
    func configureView()
    func prepare(with vendorCode: String)
}

final class MainInteractor: MainInteractorProtocol {

    weak var presenter: MainPresenterProtocol!
    var worker: MainWorkerProtocol!

    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
}

// MARK: - Public API

extension MainInteractor {
    
    final func handle(result: GetMainScreenData.Response?, error: NetworkingError?) {
        if let result = result {
            self.presenter.blocks = result.filter { $0.type != nil }.sorted(by: <)
        } else if let error = error {
            self.presenter.sendError(with: error)
        }
    }
    
    final func configureView() {
        worker.getData()
    }
    
    final func prepare(with vendorCode: String) {
        presenter.vendorCode = vendorCode
        presenter.router.show()
    }
    
}
