//
//  APIClient.swift
//  kari-pet-project
//
//  Created by Admin on 08.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias ResultCallback<Value> = (Result<Value>) -> Void

// MARK: - Declaration

final class APIClient {
    
    // MARK: - Public API
    
    func responseProcess<Response>(response: Result<Response>) -> (Response?, CustomError?) {
        switch response {
        case .success(let result):
            return (result, nil)
        case .failure(let error):
            return (nil, error)
        }
    }
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let url = URL(string: request.url) else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if error != nil {
                completion(.failure(.lostConnection))
            } else
            if let data = data {
                
                if let result = try? JSONDecoder().decode(APIResponse<T.Response>.self, from: data) {
                    
                    if let dataContainer = result.data {
                        DispatchQueue.main.async {
                            completion(.success(dataContainer))
                        }
                    } else {
                        completion(.failure(.badDecode))
                    }
                    
                } else {
                    completion(.failure(.badDecode))
                }
                
            }
            //completion(.failure(.lostConnection))
            
        }
        task.resume()
        
    }
    
    
}
