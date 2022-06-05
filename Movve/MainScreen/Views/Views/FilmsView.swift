//
//  FilmsView.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 03.06.2022.
//

import UIKit

protocol FilmsViewDelegate: AnyObject {
    func didRefreshFilms()
    func didTapSearchButton()
    func isSearchMode() -> Bool?
}

class FilmsView: UIView {
    
    weak var delegate: FilmsViewDelegate?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(didRefresh),
                                 for: .valueChanged)
        refreshControl.tintColor = .customWhite
        
        return refreshControl
    }()
    
    lazy var searchButton: UIBarButtonItem = {
        let searchButton = UIBarButtonItem(image: .magnifyingglass,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapSearchButton))
        searchButton.tintColor = .white
        
        return searchButton
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .customBlack
        searchBar.barTintColor = .customBlack
        searchBar.tintColor = .customWhite
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .customWhite
        
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .customBlack
        collectionView.refreshControl = refreshControl
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension FilmsView {
    
    func setupView() {
        backgroundColor = .customBlack
        addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let interGroupSpacing = CGFloat(20)
        
        let sectionProvider = { [unowned self] (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let currentSection = FilmSection.allCases[sectionIndex]
            
            var layoutHeight = K.Numeric.hightSectionImageHeight + K.Numeric.betweenImagesHeight
            var layoutWidth = CGFloat(0.35)
            if currentSection != .popular {
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
            if delegate?.isSearchMode() ?? false {
                section.orthogonalScrollingBehavior = .none
            } else {
                section.orthogonalScrollingBehavior = .continuous
            }
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
    
}

private extension FilmsView {
    
    @objc func didRefresh(sender: UIRefreshControl) {
        delegate?.didRefreshFilms()
    }
    
    @objc func didTapSearchButton(sender: UIBarButtonItem) {
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        delegate?.didTapSearchButton()
    }
    
}
