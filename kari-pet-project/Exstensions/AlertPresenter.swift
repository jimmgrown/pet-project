//
//  AlertPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol AlertPresenting: class {
    func showAlert(with error: NetworkingError, on view: UIViewController)
}

class AlertPresenter: AlertPresenting {
    
    func showAlert(with error: NetworkingError, on view: UIViewController) {
        error.present(on: view)
    }
    
}
