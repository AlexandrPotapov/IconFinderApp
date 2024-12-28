//
//  MultipartFormDataEncoder.swift
//  IconFinderApp
//
//  Created by Alexander on 19.12.2024.
//

import Foundation

public struct MultipartFormDataEncoder: ParameterEncoder {
    
    
//TODO: - доработать, убрать форс анвреп
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        // Создаем границу для multipart
        let boundary = "Boundary-\(UUID().uuidString)"

        // Устанавливаем заголовок Content-Type для multipart
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }

        // Создаем тело запроса
        var body = Data()

        for (key, value) in parameters {
            // Если это файл, обрабатываем как форму с файлом
            if let fileData = value as? Data {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                body.append(fileData)
                body.append("\r\n".data(using: .utf8)!)
            } else if let textValue = value as? String {
                // Обрабатываем обычные текстовые параметры
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append(textValue.data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)
            }
        }

        // Закрываем запрос
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        // Устанавливаем тело запроса
        urlRequest.httpBody = body
    }
}
