//
//  GoodsRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

protocol GoodsRouterProtocol: class {
    func show()
}

final class GoodsRouter: GoodsRouterProtocol {
    weak var viewController: GoodsVCDelegate!
    
    init(viewController: GoodsVCDelegate) {
        self.viewController = viewController
    }
    
    final func show() {
        viewController.prepare()
    }
    
}
