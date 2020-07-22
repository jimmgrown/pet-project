//
//  URLRequest+cURL.swift
//  kari-pet-project
//
//  Created by Admin on 21.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


extension URLRequest {
    
    var cURL: String {
        guard
            let url = url,
            let httpMethod = httpMethod,
            url.absoluteString.utf8.count > 0
            else { return "" }
        
        var curlCommand = "curl --verbose \\\n"
        curlCommand = curlCommand.appendingFormat(" '%@' \\\n", url.absoluteString)
        
        if "GET" != httpMethod {
            curlCommand = curlCommand.appendingFormat(" -X %@ \\\n", httpMethod)
        }
        
        let allHeadersFields = allHTTPHeaderFields!
        let allHeadersKeys = Array(allHeadersFields.keys)
        let sortedHeadersKeys  = allHeadersKeys.sorted(by: <)
        sortedHeadersKeys.forEach { curlCommand = curlCommand.appendingFormat(" -H '%@: %@' \\\n", $0, value(forHTTPHeaderField: $0)!) }
        
        if let httpBody = httpBody, httpBody.count > 0 {
            let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)!
            let escapedHttpBody = httpBodyString.replacingOccurrences(of: "'", with: "'\\''")
            curlCommand = curlCommand.appendingFormat(" --data '%@' \\\n", escapedHttpBody)
        }
        
        return curlCommand
    }
    
}
