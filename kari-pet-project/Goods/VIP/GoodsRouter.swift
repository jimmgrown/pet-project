//
//  GoodsRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

final class GoodsRouter {
    private weak var view: UIViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func showView(vendorCode: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(
            withIdentifier: GoodsVC.reuseID
            ) as? GoodsVC else { return }
        secondVC.vendorCode = vendorCode
        view.show(secondVC, sender: view)
    }
    
    
}