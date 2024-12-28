//
//  Icon.swift
//  IconFinderApp
//
//  Created by Alexander on 20.12.2024.
//

import Foundation

struct Icon: Decodable {
    let iconID: Int
    let tags: [String]
    let imageURL: String
    let imageMaxSize: Int
}
