//
//  FilmCollectionViewCell.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    
    var filmViewModel: FilmViewModel! {
        didSet {
            imageView.image = UIImage(data: filmViewModel.image ?? Data())
            titleLabel.text = filmViewModel.title
            releaseDateLabel.text = filmViewModel.releaseDate
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
    
}

private extension FilmCollectionViewCell {
    
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
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
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
