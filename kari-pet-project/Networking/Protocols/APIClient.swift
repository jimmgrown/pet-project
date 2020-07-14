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
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let url = URL(string: request.url) else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod

        #warning("Приведи в порядок вертикальные отступы в скоупе ниже")
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            #warning("Нейминг должен соответствовать естественному языку, то не dataUnwrapped, а unwrappedData")
            #warning("В optional binding конструкциях лучшей практикой является применение variable shadowing")
            #warning("guard здесь не подойдет, потому что таким образом ты игнорируешь здесь все ошибки нетворкинга")
            guard let dataUnwrapped = data else {
                return
            }
            if let result = try? JSONDecoder().decode(APIResponse<T.Response>.self, from: dataUnwrapped) {
                if let dataContainer = result.data {

                    DispatchQueue.main.async {
                        completion(.success(dataContainer))
                    }
                } else {
                    #warning("Вообще, ошибку надо развернуть через optional binding, но тут это нерелевантно, потому что нужен кастомный тип ошибки, там тебе не придется с опшналами работать")
                    completion(.failure(error.unsafelyUnwrapped))
                    print("Wrapping error")
                }
            } else {
                completion(.failure(error.unsafelyUnwrapped))
                print("Parse error")
            }
        }

        task.resume()
    }

}
