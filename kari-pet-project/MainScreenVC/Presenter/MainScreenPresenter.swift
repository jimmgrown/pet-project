//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainScreenDisplaying: class {
    func updateMainScreenData()
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Private properties
    
    private let apiClient: APIClient = .init()
    private let alertPresenter: AlertPresenting = AlertPresenter()
    private unowned let view: MainScreenDisplaying
    
    private(set) var blocks: [Block] = [] {
        didSet {
            view.updateMainScreenData()
        }
    }
    
    // MARK: Initialization
    
    init(view: MainScreenDisplaying) {
        self.view = view
    }
    
}

// MARK: - Public API

extension MainScreenPresenter: MainScreenPresenting {
    
    func getBlocksData() {
        apiClient.send(GetMainScreenData()) { result, error in
            if let result = result {
                self.blocks = result.filter { $0.type != nil }.sorted(by: <)
            } else if let error = error {
                self.alertPresenter.showAlert(with: error, on: self.view as! UIViewController)
            }
        }
    }
    
}
