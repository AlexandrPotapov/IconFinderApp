//
//  IconFinderEndPoint.swift
//  IconFinderApp
//
//  Created by Alexander on 21.12.2024.
//

import Foundation


enum IconFinderAPI {
    case searchIcons(query: String)
}

extension IconFinderAPI: EndPointType {
    var baseURL: String {
        "https://api.iconfinder.com/v4"
    }
    
    var path: String {
        switch self {
        case .searchIcons(_):
            "/icons/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchIcons(_):
                .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .searchIcons(let query):
                .requestParametersAndHeaders(bodyParameters: nil,
                                             bodyEncoding: .urlEncoding,
                                             urlParameters: ["query" : query],
                                             additionHeaders: IconFinderAPI.headers)
        }
    }
    
    
}

//MARK: - API constants

private extension IconFinderAPI {
    static let headers: [String: String] = [
        "accept": "application/json",
        "Authorization": NetworkDataFetcher.apiKey
      ]
    
}
