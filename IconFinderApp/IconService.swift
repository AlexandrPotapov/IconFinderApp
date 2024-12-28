//
//  IconService.swift
//  IconFinderApp
//
//  Created by Alexander on 20.12.2024.
//

import Foundation


struct IconService {
    
    private func getOptimizedImageURLs(for iconResponse: IconResponse) -> [ImageSize : String]? {
        var imageURLs: [ImageSize : String] = [:]
        
        // Для каждого размера изображения выбираем соответствующий URL
        for size in iconResponse.rasterSizes {
            // Проверяем размер и выбираем соответствующий размер изображения
            if let imageSize = ImageSize(rawValue: size.size) {
                imageURLs[imageSize] = size.formats.first?.previewURL
            }
        }
        
        if imageURLs.isEmpty {
            return nil
        } else {
            return imageURLs
        }
    }
    
    private func getMaxImageURLAndSize(for iconResponse: IconResponse) -> (String, Int)? {
        // Находим максимальный размер
        guard let largestRaster = iconResponse.rasterSizes.max(by: { $0.size < $1.size }),
              let url = largestRaster.formats.first?.previewURL else { return nil }
        
        
        return (url, largestRaster.size) // Возвращаем кортеж (URL, size)
    }
    
    func getIcon(for iconResponse: IconResponse, imageSize: ImageSize) -> Icon? {
        
        guard let (imageMaxURL, imageMaxSize) = getMaxImageURLAndSize(for: iconResponse)
        else { return nil }
        
        let optimizedImageURLs = getOptimizedImageURLs(for: iconResponse)
        let optimizedImageURL = optimizedImageURLs?[imageSize]
        // нужны только первые 10
        let tags = Array(iconResponse.tags.prefix(10))
        
        return Icon(
            iconID: iconResponse.iconID,
            tags: tags,
            imageURL: optimizedImageURL ?? imageMaxURL, // подумать что если максимальное изображение больше optimizedImageURL как отображать без обрезки
            imageMaxSize: imageMaxSize
        )
    }
}

enum ImageSize: Int {
    case oneX = 64
    case twoX = 128
    case threeX = 512

}
