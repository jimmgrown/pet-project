//
//  MainRouter.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol MainScreenRouting: class {
    func showView()
}

final class MainScreenRouter: MainScreenRouting {
    #warning("Почему твой раутер обращается к контроллеру через протокол, по которому к нему обращается презентер? Обязанности не разделены, получается. И вообще в плане взаимодействия раутера с контроллером оба протокола можно опустить и использовать конкретные типы")
    weak var view: MainScreenDisplaying!
    
    init(view: MainScreenDisplaying) {
        self.view = view
    }
    
}

extension MainScreenRouter {
    
    func showView() {
        view.prepare()
    }
    
}
