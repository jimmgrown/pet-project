//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainScreenDisplaying: ErrorDisplaying {
    func updateTableViewData()
    func updateUI(viewModel: MainScreen.GetBlocksDataAction.ViewModel)
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Properties
    
    weak var view: MainScreenDisplaying?
    
}

// MARK: - MainScreenPresenting

extension MainScreenPresenter: MainScreen.Presenting {
    
    func handle(response: MainScreen.GetBlocksDataAction.Response) {
        if let data = response.data {
            let blocks = data.filter { $0.type != nil }.sorted(by: <)
            view?.updateUI(viewModel: MainScreen.GetBlocksDataAction.ViewModel(blocks: blocks))
            view?.updateTableViewData()
        } else if let error = response.error {
            view?.showAlert(with: error)
        }
    }
    
}
