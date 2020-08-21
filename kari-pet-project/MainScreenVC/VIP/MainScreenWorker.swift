//
//  MainWorker.swift
//  kari-pet-project
//
//  Created by Admin on 06.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("У воркера по дефолту не должно быть протокола для обращений из интерактора. Он вводится только тогда, когда у тебя несколько воркеров для различных запросов, и ты хочешь их замокать в тестах. И то, у каждого воркера будет свой отдельный протокол, а не какой-то общий ...Working. Да и вообще, воркер - очень редкая сущность, он почти никогда не нужен. В большинстве ситуаций его задачи на себя берет интерактор. В кари, к примеру, нет ни одного воркера.")
protocol MainScreenWorking: class {
    func getBlocksData()
}

#warning("Не вижу смысла делать его классом")
final class MainScreenWorker {
    
    #warning("Воркер никогда не должен иметь ссылки на интерактор, так как воркер - абстрактная сущность. Передавать полученные данные в интерактор нужно через хендлеры, который должны быть переданы в вызовах методов воркера")
    weak var interactor: MainScreenInteracting?
    private let apiClient: APIClient = .init()
    
}

extension MainScreenWorker: MainScreenWorking {
    
    func getBlocksData() {
        apiClient.send(GetMainScreenData()) { result, error in
            self.interactor?.handle(result: result, error: error)
        }
    }
    
}
