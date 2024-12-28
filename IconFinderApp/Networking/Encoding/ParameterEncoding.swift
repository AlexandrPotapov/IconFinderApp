//
//  ParameterEncoding.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws // inout для преобразования URLRequest в роутере
}

public enum ParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case multipartFormDataEncoding
    case urlAndJsonEncoding
    case urlAndMultipartFormDataEncoding

    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else {
                    throw NetworkServiceError.missingParameters
                }
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else {
                    throw NetworkServiceError.missingParameters
                }
                
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .multipartFormDataEncoding:
                guard let bodyParameters = bodyParameters else {
                    throw NetworkServiceError.missingParameters
                }
                
                try MultipartFormDataEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else {
                    throw NetworkServiceError.missingParameters
                }
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
                case .urlAndMultipartFormDataEncoding:
                guard let bodyParameters = bodyParameters,
                      let urlParameters = urlParameters else {
                    throw NetworkServiceError.missingParameters
                }
                
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try MultipartFormDataEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            throw error
        }
    }
}
