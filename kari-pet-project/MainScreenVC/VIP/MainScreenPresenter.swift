//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainScreenDisplaying: Displaying {
    var interactor: MainScreenInteracting { get set }
    var router: MainScreenRouter { get set }
    func updateData()
    func showAlert(with error: NetworkingError)
}

// MARK: - Declaration

final class MainScreenPresenter: MainScreenPresenting {
    
    // MARK: Properties
    
    weak var view: MainScreenDisplaying!
    
    var blocks: [Block] = [] {
        didSet {
            view.updateData()
        }
    }
    
    // MARK: - Initialization
    
    init(view: MainScreenDisplaying) {
        self.view = view
    }
    
}
