//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol VCDelegate: class {
    var presenter: MainVCPresenter! { get set }
    func prepare()
    func updateData()
    func getResponse(with error: NetworkingError)
}

protocol MainPresenterProtocol: class {
    var vendoreCode: String { get set }
    #warning("Если у тебя есть это")
    var blocks: [Block] { get set }
    var delegate: VCDelegate! { get set }
    var router: MainRouterProtocol! { set get }
    func configureView()
    #warning("То зачем здесь это?")
    func blocksCount() -> Int
}

// MARK: - Declaration

#warning("final")
class MainVCPresenter: MainPresenterProtocol {
    
    #warning("Иниты принято после пропертей декларировать")
    init(view: VCDelegate) {
        self.delegate = view
    }
    
    // MARK: Properties
    
    weak var delegate: VCDelegate!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    #warning("vendor")
    var vendoreCode: String = ""
    
    var blocks: [Block] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

#warning("Конформанс под протокол должен быть тут")
extension MainVCPresenter {

    #warning("final не нужен")
    final func configureView() {
        self.interactor.getData()
    }
    
    final func blocksCount() -> Int {
        return blocks.count
    }
    
}
