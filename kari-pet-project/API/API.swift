import Foundation
import UIKit

typealias JSON = [String: Any]

enum API {

    static var mainScreenURL: String { return "https://i.api.kari.com/mobile/v2/screen/main?locationId=7400000100000&client=app_mobile" }
    
    static func loadJSON(completion: @escaping (Response) -> Void) {
        guard let url = URL(string: mainScreenURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                if let result = try? JSONDecoder().decode(Response.self,from:data!) {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } else {
                    print("Parse error")
                }
                    //print(try JSONSerialization.jsonObject(with: data!, options: []))
            
        }
        task.resume()
    }
    
}
