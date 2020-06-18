//
//  API.swift
//  kari-pet-project
//
//  Created by Admin on 09.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

#warning("Вертикальные отступы")
#warning("Очень ad-hoc API клиент получился. Что ты собираешься делать, когда новые запросы появятся?")
typealias JSON = [String: Any]
enum API {
    #warning("Зачем ты сохраняешь результат одного какого-то запроса аж в глобальную память? Да и вообще, зачем ты его тут сохраняешь?")
    static var result = Response(blocks: [Block]())
    static var baseURL: String { return "https://i.api.kari.com/mobile/v2/screen/main?locationId=7400000100000&client=app_mobile" }
    static func loadJSON(completion: @escaping (Response) -> Void) {
        #warning("Забывай по-тихоньку про force unwrap")
        let url = URL(string: baseURL)!
        let request = URLRequest(url: url)
        #warning("Не ставь скобки для параметров клоужера, так как их можно перепутать с таплом")
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            #warning("Подумай, на каком треде ты тут находишься и исправь ошибку")
            if error == nil {
                do {
                    #warning("Горизонтальные отступы")
                    if let result = try? JSONDecoder().decode(Response.self,from:data!) {
                        self.result = result
                    }
                    //print(try JSONSerialization.jsonObject(with: data!, options: []))
                    //print(self.result.blocks[7], "TestPrint")
                    completion(result)
                #warning("Компилятор выдает ворнинги не просто так, их надо исправлять")
                } catch {
                    print("Parse error")
                }
            }
        }
        task.resume()
    }
}
