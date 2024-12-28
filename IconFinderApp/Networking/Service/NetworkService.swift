//
//  NetworkService.swift
//  IconFinderApp
//
//  Created by Alexander on 18.12.2024.
//

import Foundation

public final class NetworkService<EndPoint: EndPointType>: NetworkServiceProtocol {
    
    private var task: URLSessionTask?
    
    public func request(_ rout: EndPoint, _ completion: @escaping NetworkServiceCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: rout)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                NetworkLogger.log(response: response ?? URLResponse())
                let networkResponse = NetworkResponse(response: response, data: data)
                completion(networkResponse, error)
            })
        }catch {
            completion(nil, error)
        }
        self.task?.resume()
    }
    
    public func simpleRequest(url: String, completion: @escaping NetworkServiceCompletion) {
        guard let url = URL(string: url) else {
            completion(nil, NetworkServiceError.invalidURL)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let networkResponse = NetworkResponse(response: response, data: data)
            completion(networkResponse, error)
        }
        task.resume()
    }
    
    public func cancel() {
        self.task?.cancel()
    }
    
    private func buildRequest(from rout: EndPoint) throws -> URLRequest {
        
        guard let baseURL = URL(string: rout.baseURL) else {
        
            throw NetworkServiceError.invalidURL
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent(rout.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = rout.httpMethod.rawValue
        do {
            switch rout.task {
            case .request: break
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
