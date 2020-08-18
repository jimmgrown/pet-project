//
//  Displaying.swift
//  kari-pet-project
//
//  Created by Admin on 18.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol Displaying: class {}

extension Displaying where Self: UIViewController {
    
    func showAlert(with error: NetworkingError) {
        error.present(on: self)
    }
    
}
