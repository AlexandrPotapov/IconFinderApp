//
//  NetworkResponse.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

public struct NetworkResponse {
    public let statusCode: Int
    public let data: Data?
    
    public init(statusCode: Int, data: Data?) {
        self.statusCode = statusCode
        self.data = data
    }
}
