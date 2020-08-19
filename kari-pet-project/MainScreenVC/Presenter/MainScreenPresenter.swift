//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol MainScreenDisplaying: Displaying {
    #warning("Зачем тут это")
    var presenter: MainScreenPresenting { get set }
    #warning("Я же уже писал и в MVP, и тут, что имена надо менее общие выбирать. Больше конкретики")
    func updateData()
    #warning("Это нужно отрефакторить так же, как в MVP")
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Properties
    
    unowned let view: MainScreenDisplaying
    var interactor: MainScreenInteracting!
    var router: MainScreenRouter!
    var vendorCode: String = ""
    
    var blocks: [Block] = [] {
        didSet {
            view.updateData()
        }
    }
    
    // MARK: Initialization
    
    #warning("В вайпере не принято инджектить сущности через инит. Тем более, у тебя ко view в любом случае доступ не ограничен, так что все подобные иниты нужно убрать")
    init(view: MainScreenDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension MainScreenPresenter: MainScreenPresenting {

    func configureView() {
        self.interactor.getBlocksData()
    }
    
}
