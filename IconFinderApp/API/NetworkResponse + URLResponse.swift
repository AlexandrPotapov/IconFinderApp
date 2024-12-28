//
//  NetworkResponse + URLResponse.swift
//  IconFinderApp
//
//  Created by Alexander on 19.12.2024.
//

import Foundation

// Расширение для инициализации из URLResponse
extension NetworkResponse {
    init(response: ?, data: Data?) {
        let httpResponse = response as? HTTPURLResponse
        self.init(
            statusCode: httpResponse?.statusCode ?? -1,
            data: data
        )
    }
}
