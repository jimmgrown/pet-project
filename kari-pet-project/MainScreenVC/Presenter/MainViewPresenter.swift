//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol VCDelegate {
    func updateData()
    func getResponse(with error: NetworkingError)
}

// MARK: - Declaration

final class MainVCPresenter: NSObject {
    
    // MARK: Private properties
    
    private let apiClient = APIClient()
    
    // MARK: Properties
    
    var delegate: VCDelegate!
    
    var blocks: [Block] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension MainVCPresenter {
    
    final func getData() {
        apiClient.send(GetMainScreenData()) { response in
            self.apiClient.handle(response: response) { result, error in
                if let result = result {
                    self.blocks = result.filter { $0.type != nil }.sorted(by: <)
                } else if let error = error {
                    self.delegate.getResponse(with: error)
                }
            }
        }
    }
    
    final func blocksCount() -> Int {
        return blocks.count
    }
    
}
