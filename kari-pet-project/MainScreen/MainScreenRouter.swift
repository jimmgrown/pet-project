//
//  MainRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainScreenRouting {
    func goToGoodsVC()
}

protocol MainScreenDataPassing {
    var dataStore: MainScreenDataStore? { get set}
}

final class MainScreenRouter {
    weak var view: UIViewController?
    var dataStore: MainScreenDataStore?
}

extension MainScreenRouter: MainScreenDataPassing, MainScreenRouting {
    
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
