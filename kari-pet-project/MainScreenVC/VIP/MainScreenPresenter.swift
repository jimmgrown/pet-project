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
    func getBlocksCount(blocksCount: Int)
    func getBlocksData(blocks: [Block])
}

// MARK: - Declaration

final class MainScreenPresenter {
    
    // MARK: Properties
    
    weak var view: MainScreenDisplaying?
    
    private(set) var blocks: [Block] = [] {
        didSet {
            sendBlocksData(blocks: blocks)
            sendBlocksCount()
            view?.updateTableViewData()
        }
    }
    
}

// MARK: - MainScreenPresenting

extension MainScreenPresenter: MainScreenPresenting {
    
    func getBlocksData(blocks: [Block]) {
        self.blocks = blocks
    }
    
    func showAlert(with error: NetworkingError) {
        view?.showAlert(with: error)
    }
    
    func sendBlocksData(blocks: [Block]) {
        view?.getBlocksData(blocks: blocks)
    }
    
    func sendBlocksCount() {
        view?.getBlocksCount(blocksCount: blocks.count)
    }
    
}
