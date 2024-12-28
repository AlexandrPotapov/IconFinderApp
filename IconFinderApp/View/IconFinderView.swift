//
//  IconFinderView.swift
//  IconFinderApp
//
//  Created by Alexander on 17.12.2024.
//

import UIKit

final class IconFinderView: UIView {
    
    
    var presenter: IconFinderPresenterProtocol?
    private var viewModels = [IconFinderViewModel]()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(IconFinderTableViewCell.self, forCellReuseIdentifier: IconFinderTableViewCell.id)
//        view.separatorInset = .zero
        view.tableFooterView = UIView()
        view.backgroundColor = .systemBackground
//        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        return view
    }()
    
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource
extension IconFinderView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IconFinderTableViewCell.id) as? IconFinderTableViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = viewModels[indexPath.row]
        cell.update(with: viewModel)
        return cell
    }
}


// MARK: - IconFinderViewProtocol
extension IconFinderView: IconFinderViewProtocol {
    func showIcons(_ viewModels: [IconFinderViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

private extension IconFinderView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        )
    }
}
