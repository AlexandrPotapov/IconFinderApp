//
//  NetworkDataFetcher.swift
//  IconFinderApp
//
//  Created by Alexander on 20.12.2024.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    func getIcons(query: String, response: @escaping (_ icon: Icon?, _ error: Error?) -> Void)

}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    static let apiKey = "YOUR_API_KEY"
    
    private let networkService = NetworkService<IconFinderAPI>()

    func getIcons(query: String, response: @escaping (_ icon: Icon?, _ error: Error?) -> Void) {
        networkService.request(.searchIcons(query: query)) { networkResponse, error in
            
            if let error = error {
                return response(nil, NetworkResponseDescription.noData)
            }
            
            guard let networkResponse = networkResponse, networkResponse.statusCode == 200 else {
                return response(nil, NetworkResponseDescription.networkRequestFailed)
            }
            
            guard let data = networkResponse.data else {
                return response(nil, NetworkResponseDescription.noData)
            }
            
            let icon = self.decodeJSON(type: Icon.self, from: data)
            
            return response(icon , nil)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let response = try decoder.decode(type.self, from: data)
            return response
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}



enum NetworkResponseDescription: Error, LocalizedError {
    case authenticationError
    case badRequest
    case outdated
    case networkRequestFailed
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .authenticationError:
            return NSLocalizedString("Authentication error", comment: "Authentication error")
        case .badRequest:
            return  NSLocalizedString("Bad request", comment: "Bad request")
        case .outdated:
            return  NSLocalizedString("Outdated", comment: "Outdated")
        case .networkRequestFailed:
            return  NSLocalizedString("Network request failed", comment: "Network request failed")
        case .noData:
            return NSLocalizedString("No Data", comment: "Response returned with no data to decode")
        case .unableToDecode:
            return  NSLocalizedString("Unable To Decode", comment: "We could not decode the response.")
        }
    }
}
