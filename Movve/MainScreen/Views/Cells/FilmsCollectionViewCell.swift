//
//  FilmCollectionViewCell.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

class FilmsCollectionViewCell: UICollectionViewCell  {
    
    typealias ViewModel = FilmViewModel
    
    lazy var imageHeightPopularConstraint = imageView.heightAnchor.constraint(equalToConstant:
                                                                              K.Numeric.hightSectionImageHeight)
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModelChanged(viewModel)
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = .preferredFont(forTextStyle: .callout,
                                    compatibleWith: .init(legibilityWeight: .bold))
        label.numberOfLines = 2
        
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .customGray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewModelChanged(_ viewModel: ViewModel) {
        imageView.image = UIImage(data: viewModel.image ?? Data())
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        imageHeightPopularConstraint.constant = viewModel.imageHeightConstant
        imageHeightPopularConstraint.isActive = true
    }
    
}

private extension FilmsCollectionViewCell {
    
    func setupView() {
        contentView.addSubviews([
            imageView,
            titleLabel,
            releaseDateLabel
        ])
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            releaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
}
