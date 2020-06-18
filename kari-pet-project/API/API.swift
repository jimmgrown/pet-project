//
//  API.swift
//  kari-pet-project
//
//  Created by Admin on 09.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

typealias JSON = [String: Any]
enum API {
    static var result = Response(blocks: [Block]())
    static var baseURL: String { return "https://i.api.kari.com/mobile/v2/screen/main?locationId=7400000100000&client=app_mobile" }
    static func loadJSON(completion: @escaping (Response) -> Void) {
        let url = URL(string: baseURL)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error == nil {
                do {
                    if let result = try? JSONDecoder().decode(Response.self,from:data!) {
                        self.result = result
                    }
                    //print(try JSONSerialization.jsonObject(with: data!, options: []))
                    //print(self.result.blocks[7], "TestPrint")
                    completion(result)
                } catch {
                    print("Parse error")
                }
            }
        }
        task.resume()
    }
}
