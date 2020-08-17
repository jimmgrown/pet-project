//
//  MainViewPresenter.swift
//  kari-pet-project
//
//  Created by Admin on 04.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

#warning("Все ворнинги отсюда справедливы и для модуля Goods, там тоже все это нужно исправить")

#warning("Протоколы нужно указывать в том файле, в котором вызываются (!!!не объявляются, а именно вызываются!!!) методы этого протокола. Т.е протокол для контроллера должен находиться тут, а протокол для презентера — в файле контроллера. Либо можно делать отдельный файл для всех протоколов, тоже допустимо")

#warning("Нейминг протоколов все еще хромает. VCDelegate - слишком общее название для протокола, предназначенного для определенного контроллера. Должно быть типа MainScreenDisplaying")
protocol VCDelegate: class {
    #warning("Выбирай менее общие имена, ничего же не понятно из такой сигнатур методов")
    func updateData()
    #warning("Почему этот метод вызывается только при ошибке? Респонс без ошибки - не респонс что ли по такой логике?")
    func getResponse(with error: NetworkingError)
}

#warning("А в данном случае протокол назван как конкретный объект, что недопустимо. У тебя даже проблема вышла, что ты протоколом занял это имя и не смог назвать класс самого презентера так. Еще и выкрутился из ситуации не очень — что за инфикс VC у презентера? Короче, это протокол должен выражать действие, а не объект, поэтому назван должен быть MainScreenPresenting. И обрати внимание на то, как ты вразброс именуешь сущности: контроллер назван MainScreenVC, значит, префиксом модуля можно считать MainScreen. В итоге, ты этот протокол назвал с префиксом Main, сам презентер — с префиксом MainVC, а файл - вообще с префиксом MainView. Так точно нельзя делать")
protocol MainPresenter {
    #warning("Выбирай менее общие имена, ничего же не понятно из такой сигнатуры метода")
    func getData()
    #warning("Почему это метод, а не компьютед проперти? + странное решение, учитывая, что ты полностью экспоузишь blocks. Можно ведь просто к их проперти count обратиться, занеся blocks в протокол")
    func blocksCount() -> Int
}

// MARK: - Declaration

final class MainVCPresenter: MainPresenter {
    
    // MARK: Private properties
    
    #warning("Нужен эксплисит тип у проперти. Чтобы не дублировать, после = можешь .init() указывать")
    private let apiClient = APIClient()
    
    // MARK: Properties
    
    #warning("weak + ! не имеет никакого смысла, потому что weak семантически подразумевает опшнал. Тут нужен unowned + я бы избавился вообще от опциональности, перенеся это в инит")
    weak var delegate: VCDelegate!
    
    #warning("Ты обращаешься к этому презентеру через протокол, в котором нет этой проперти. Почему она тогда internal? Вообще у нее должен быть internal get и private set и в протоколе должен быть { get } реквайрмент, если тебе нужно обращаться к блокам в дальнейшем из контроллера. Если не надо, то можно (и даже нужно) ее вообще закрыть целиком, но в твоем случае (так как нужен count) надо реализовать первый вариант")
    var blocks: [Block] = [] {
        didSet {
            delegate.updateData()
        }
    }
    
}

// MARK: - Public API

extension MainVCPresenter {
    
    #warning("Зачем тут final модификаторы?")
    final func getData() {
        apiClient.send(GetMainScreenData()) { response in
            #warning("Почему ты везде вызываешь этот handle после запросов? Видно же, что это надо экстрактнуть либо в сам апи клиент, либо в какой-то промежуточный протокол.")
            self.apiClient.handle(response: response) { result, error in
                if let result = result {
                    self.blocks = result.filter { $0.type != nil }.sorted(by: <)
                } else if let error = error {
                    self.delegate.getResponse(with: error)
                }
            }
        }
    }
    
    final func blocksCount() -> Int {
        return blocks.count
    }
    
}
