//
//  GoodsRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol GoodsRouting {
    func goToGoodsVC()
}

protocol GoodsDataPassing {
    var dataStore: Goods.DataStore? { get set }
}

final class GoodsRouter {
    weak var view: UIViewController?
    var dataStore: Goods.DataStore?
}

extension GoodsRouter: Goods.DataPassing, Goods.Routing {
    
    func goToGoodsVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(
            withIdentifier: GoodsVC.reuseID
            ) as? GoodsVC else { return }
        if let vendorCode = dataStore?.vendorCode {
            secondVC.vendorCode = vendorCode
        }
        view?.show(secondVC, sender: view)
    }
    
}
