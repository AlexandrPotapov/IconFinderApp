//
//  NetworkServiceProtocol.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

public typealias NetworkServiceCompletion = (_ networkResponse: NetworkResponse?,_ error: Error?)->()

public protocol NetworkServiceProtocol {
    associatedtype EndPoint: EndPointType
    func request(_ rout: EndPoint, _ completion: @escaping NetworkServiceCompletion)
    func simpleRequest(url: String, completion: @escaping NetworkServiceCompletion)
    func cancel()
}
