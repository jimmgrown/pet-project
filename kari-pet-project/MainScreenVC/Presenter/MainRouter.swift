//
//  MainRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainRouterProtocol: class {
    func show()
}

class MainRouter: MainRouterProtocol {
    weak var viewController: VCDelegate!
    
    init(viewController: VCDelegate) {
        self.viewController = viewController
    }

    func show() {
        viewController.prepare()
    }
    
}
