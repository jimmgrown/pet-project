//
//  MainRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Здесь непонятно как перейти на новый контроллер")

protocol MainRouterProtocol: class {
}

class MainRouter: MainRouterProtocol {
    weak var viewController: VCDelegate!
    
    init(viewController: VCDelegate) {
        self.viewController = viewController
    }

}
