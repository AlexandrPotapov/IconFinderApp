//
//  NetworkLogger.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod ?? ""
        let path = urlComponents?.path ?? ""
        let query = urlComponents?.query ?? ""
        let host = urlComponents?.host ?? ""
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n\(String(data: body, encoding: .utf8) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: URLResponse) {
        print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - - END - - - - - - - - - - \n") }
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        var logOutput = "RESPONSE: \(httpResponse.url?.absoluteString ?? "")\n"
        logOutput += "STATUS CODE: \(httpResponse.statusCode)\n"
        for (key, value) in httpResponse.allHeaderFields {
            logOutput += "\(key): \(value)\n"
        }
        
        print(logOutput)
    }
}

