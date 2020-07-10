//
//  APIClient.swift
//  kari-pet-project
//
//  Created by Admin on 08.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias ResultCallback<Value> = (Result<Value>) -> Void

final class APIClient {
    
    #warning("Зачем ты завернул респонс в контейнер? Контейнер нужен только для парсинга, возвращать можно уже только внутренние данные")
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) {
        #warning("client можно захардкодить")
        guard let url = URL(string: API.Main.mainScreenURL(client: "app_mobile")) else {
            return
        }

        #warning("Что будешь делать, если появится запрос с другим http методом?")
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            #warning("Где обработка ошибки и почему data форс анрэпится?")
            if let result = try? JSONDecoder().decode(APIResponse<T.Response>.self, from: data!) {
                if let dataContainer = result.data {
                    DispatchQueue.main.async {
                        completion(.success(dataContainer))
                    }
                } else {
                    print("Parse error")
                }
            }
        }
        
        task.resume()
    }
    
}

// MARK: Old working version

//typealias JSON = [String: Any]
//
//enum APIClient {
//
//    static func loadMainScreen(completion: @escaping (ResponseMainScreen) -> Void) {
//        guard let url = URL(string: API.Main.mainScreenURL(client: "app_mobile")) else {
//            return
//        }
//
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//
//            if let result = try? JSONDecoder().decode(ResponseMainScreen.self,from:data!) {
//                DispatchQueue.main.async {
//                    completion(result)
//                }
//            } else {
//                print("Parse error")
//            }
//            //print(try JSONSerialization.jsonObject(with: data!, options: []))
//
//        }
//        task.resume()
//    }
//}
