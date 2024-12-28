//
//  IconFinderProtocols.swift
//  IconFinderApp
//
//  Created by Alexander on 17.12.2024.
//

import Foundation


protocol IconFinderViewProtocol {
    func showIcons(_ viewModels: [IconFinderViewModel])
}
protocol IconFinderPresenterProtocol {
    func viewDidLoad()
}

protocol IconFinderModelProtocol {
    func fetchIcons()
}
