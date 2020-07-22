//
//  APIClient.swift
//  kari-pet-project
//
//  Created by Admin on 08.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias ResultCallback<Value> = (Result<Value, NetworkingError>) -> Void
typealias NetworkHandler<T> = (T?, NetworkingError?) -> Void

// MARK: - Declaration

final class APIClient {
    
    // MARK: - Public API
    
    func handle<Response>(response: Result<Response, NetworkingError>, completion: NetworkHandler<Response>) {
        switch response {
        case .success(let result):
            completion(result, nil)
        case .failure(let error):
            completion(nil, error)
        }
    }
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let url = URL(string: request.url) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        print(urlRequest.cURL)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response , error in
            print(response)
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 580 || response.statusCode == 401 || response.statusCode == 400 {
                    DispatchQueue.main.async {
                        completion(.failure(.badRequest))
                    }
                }
            }
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.lostConnection))
                }
            } else if let data = data {
                if let result = try? JSONDecoder().decode(APIResponse<T.Response>.self, from: data) {
                    print(result.message)
                    if let dataContainer = result.data {
                        DispatchQueue.main.async {
                            completion(.success(dataContainer))
                        }
                    } else {
                        DispatchQueue.main.async {
                            print("lvl1 badDecode")
                            completion(.failure(.badDecode))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.badDecode))
                    }
                }
            }
            
        }
        
        task.resume()
    }
    
}
