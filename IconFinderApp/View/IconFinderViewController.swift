//
//  IconFinderViewController.swift
//  IconFinderApp
//
//  Created by Alexander on 16.12.2024.
//

import UIKit

final class IconFinderViewController: UIViewController {
    
    var presenter: IconFinderPresenterProtocol?
    
    private lazy var customView = IconFinderView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Products"
        customView.presenter = presenter
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backButtonTitle = self.title
    }
}

extension IconFinderViewController: IconFinderViewProtocol {
    func showIcons(_ viewModels: [IconFinderViewModel]) {
        customView.showIcons(viewModels)
    }
}
