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
    
    final func handle<Response>(response: Result<Response, NetworkingError>, completion: NetworkHandler<Response>) {
        
        switch response {
        case .success(let result):
            completion(result, nil)
        case .failure(let error):
            completion(nil, error)
        }
        
    }
    
    final func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let url = URL(string: request.url) else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if request.httpMethod != .get {
            urlRequest.httpBody = try? JSONEncoder().encode(request)
        }
        print(urlRequest.cURL)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.lostConnection))
                }
            } else if let data = data {
                if let result = try? JSONDecoder().decode(APIResponse<T.Response>.self, from: data) {
                    switch result.statusCode {
                    case 580, 400, 500:
                        if let message = result.message {
                            DispatchQueue.main.async {
                                completion(.failure(.serverError(message: message)))
                            }
                        }
                    default:
                        break
                    }
                    if let dataContainer = result.data {
                        DispatchQueue.main.async {
                            completion(.success(dataContainer))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(.badUnwrapping))
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
