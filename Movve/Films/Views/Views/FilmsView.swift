//
//  FilmsView.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 03.06.2022.
//

import UIKit

protocol FilmsViewDelegate: AnyObject {
    func didRefresh()
}

class FilmsView: UIView {
    
    weak var delegate: FilmsViewDelegate?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        refreshControl.tintColor = .customWhite
        
        return refreshControl
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .customBlack
        searchBar.barTintColor = .customBlack
        searchBar.isHidden = true
        searchBar.tintColor = .customWhite
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .customWhite
        
        return searchBar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.tintColor = .customWhite
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        button.setImage(.magnifyingglass, for: .normal)
        
        return button
    }()
    
    let customTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle,
                                    compatibleWith: .init(legibilityWeight: .bold))
        var myMutableString = NSMutableAttributedString(string: "Movve")
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.white,
                                     range: NSRange(location: 0, length: 3))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor,
                                     value: UIColor.red,
                                     range: NSRange(location: 3, length: 2))
        
        label.attributedText = myMutableString
        
        label.backgroundColor = .clear
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        collectionView.backgroundColor = .customBlack
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupTapRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension FilmsView {
    
    func setupView() {
        backgroundColor = .customBlack
        addSubviews([
            searchBar,
            customTitle,
            searchButton,
            collectionView
        ])
        setupConstraints()
    }
    
    func setupConstraints() {
        let defaultBorderConstraint = CGFloat(20)
        NSLayoutConstraint.activate([
            customTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultBorderConstraint),
            
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultBorderConstraint / 2),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -defaultBorderConstraint / 2),
            searchBar.centerYAnchor.constraint(equalTo: customTitle.centerYAnchor),
            
            searchButton.centerYAnchor.constraint(equalTo: customTitle.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -defaultBorderConstraint),
            
            collectionView.topAnchor.constraint(equalTo: customTitle.bottomAnchor, constant: defaultBorderConstraint),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let interGroupSpacing = CGFloat(20)
        
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let filmSection = FilmSection.allCases[sectionIndex]
            
            var layoutHeight = K.Numeric.hightSectionImageHeight + K.Numeric.betweenImagesHeight
            var layoutWidth = CGFloat(0.35)
            if filmSection != .popular {
                layoutHeight = K.Numeric.lowSectionImageHeight + K.Numeric.betweenImagesHeight
                layoutWidth = 0.3
            }
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(layoutHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(layoutWidth),
                                                   heightDimension: .absolute(layoutHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = interGroupSpacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                            leading: interGroupSpacing,
                                                            bottom: 0,
                                                            trailing: interGroupSpacing)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(44))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = interGroupSpacing
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        
        return layout
    }
    
    func setupSearchBar(isHidden: Bool) {
        searchButton.isHidden = !isHidden
        customTitle.isHidden = !isHidden
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { [unowned self] in
            searchBar.isHidden = isHidden
        })
    }
    
    func setupTapRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
}

private extension FilmsView {
    
    @objc func didTapSearchButton() {
        setupSearchBar(isHidden: false)
    }
    
    @objc func didTapView() {
        setupSearchBar(isHidden: true)
    }
    
    @objc func didRefresh(sender: UIRefreshControl) {
        delegate?.didRefresh()
    }
}
