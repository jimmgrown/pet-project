import Foundation
import UIKit

#warning("Очень ad-hoc API клиент получился. Что ты собираешься делать, когда новые запросы появятся?")
typealias JSON = [String: Any]

enum API {

    static var baseURL: String { return "https://i.api.kari.com/mobile/v2/screen/main?locationId=7400000100000&client=app_mobile" }
    
    static func loadJSON(completion: @escaping (Response) -> Void) {
        guard let url = URL(string: baseURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            #warning("Подумай, на каком треде ты тут находишься и исправь ошибку")
                
                if let result = try? JSONDecoder().decode(Response.self,from:data!) {
                    //print(result.blocks[7], "TestPrint")
                    completion(result)
                } else {
                    print("Parse error")
                }
                    //print(try JSONSerialization.jsonObject(with: data!, options: []))
            
        }
        task.resume()
    }
}
