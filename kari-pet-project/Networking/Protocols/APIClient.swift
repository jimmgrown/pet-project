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
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let dataUnwrapped = data else {
                return
            }
            if let result = try? JSONDecoder().decode(APIResponse<T.Response>.self, from: dataUnwrapped) {
                if let dataContainer = result.data {
                    
                    DispatchQueue.main.async {
                        completion(.success(dataContainer))
                    }
                } else {
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
