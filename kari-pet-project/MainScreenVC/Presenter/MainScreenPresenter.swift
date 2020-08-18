//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainScreenDisplaying: class {
    var presenter: MainScreenPresenting { get set }
    func prepare()
    func updateData()
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Properties
    
    var delegate: MainScreenDisplaying
    var interactor: MainScreenInteracting!
    var router: MainScreenRouting!
    var vendorCode: String = ""
    
    var blocks: [Block] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
    // MARK: Initialization
    
    init(view: MainScreenDisplaying) {
        self.delegate = view
    }
    
}

// MARK: - Public API

extension MainScreenPresenter: MainScreenPresenting {

    func configureView() {
        self.interactor.getData()
    }
    
}
