//
//  IconFinderTableViewCell.swift
//  IconFinderApp
//
//  Created by Alexander on 17.12.2024.
//

import UIKit

final class IconFinderTableViewCell: UITableViewCell {
    static let id = "IconFinderTableViewCell"
        
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center // для оптимизации
        return imageView
    }()
    
    private lazy var imageLargestSizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var isSavedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageLargestSizeLabel, tagsLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, labelsStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        selectionStyle = .none
        tintColor = .systemRed
        
        setupSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with viewModel: IconFinderViewModel) {
        iconImageView.image = viewModel.image
        imageLargestSizeLabel.text = viewModel.imageLargestSizeLabelText
        tagsLabel.text = viewModel.tagsLabelText
    }
}


private extension IconFinderTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(cellStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
}
