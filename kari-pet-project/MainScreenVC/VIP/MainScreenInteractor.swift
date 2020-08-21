//
//  MainInteractor.swift
//  kari-pet-project
//
//  Created by Admin on 05.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Что здесь забыл этот протокол?")
protocol MainScreenInteracting: class {
    #warning("Почему этот метод в протоколе? Будет странно, если контроллер сможет его вызвать. Ты здесь как раз-таки забил на принцип Interface Segregation, и не разбил этот протокол на два: по одному из них к интерактору должен обращаться контроллер, а по другому — воркер.")
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?)
    func configureView()
}

final class MainScreenInteractor {
    
    // MARK: Properties
    
    var presenter: MainScreenPresenting!
    var worker: MainScreenWorking!
    
}

// MARK: - MainScreenInteracting

extension MainScreenInteractor: MainScreenInteracting {
    
    func handle(result: GetMainScreenData.Response?, error: NetworkingError?) {
        if let result = result {
            #warning("Почему у тебя в интеракторе презентационная логика? В таком виде твой презентер тупо ничего не делает")
            let blocks = result.filter { $0.type != nil }.sorted(by: <)
            #warning("get подразумевает, что ты собрался получать какие-то данные. Но ты же ведь только что их получил. В вызове этого метода ты их уже передаешь, так что нужно другое имя")
            self.presenter.getBlocksData(blocks: blocks)
        } else if let error = error {
            self.presenter.showAlert(with: error)
        }
    }
    
    func configureView() {
        worker.getBlocksData()
    }
    
}
