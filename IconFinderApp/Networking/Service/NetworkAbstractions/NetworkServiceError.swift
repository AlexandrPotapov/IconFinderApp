//
//  NetworkServiceError.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

public enum NetworkServiceError: Error {
    case invalidURL
    case missingURL
    case noData
    case parsingError
    case timeout
    case encodingFailed
    case missingParameters
    case undefeated
}

