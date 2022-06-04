//
//  TitleSupplementaryView.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 01.06.2022.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    
    static let reuseIdentifier = "TitleSupplementaryView"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = .preferredFont(forTextStyle: .title3,
                                    compatibleWith: .init(legibilityWeight: .bold))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {
    func configure() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
