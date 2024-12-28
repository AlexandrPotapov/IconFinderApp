//
//  Requestable.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

public protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    
}
