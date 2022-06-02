//
//  FilmsViewController.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

extension FilmsViewController {
    
    typealias CustomCellRegistration = UICollectionView.CellRegistration<FilmsCollectionViewCell, FilmViewModel>
    typealias CustomDataSource = UICollectionViewDiffableDataSource<FilmSection, FilmViewModel>
    typealias CustomSnapshot = NSDiffableDataSourceSnapshot<FilmSection, FilmViewModel>
    
}

class FilmsViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    private var filmsViewModel: FilmsViewModelProtocol = FilmsViewModel()
    private var dataSource: CustomDataSource!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .customBlack
        searchBar.barTintColor = .customBlack
        searchBar.isHidden = true
        searchBar.delegate = self
        searchBar.tintColor = .customWhite
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .customWhite
        
        return searchBar
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.tintColor = .customWhite
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        button.setImage(.magnifyingglass, for: .normal)
        
        return button
    }()
    
    private let customTitle: UILabel = {
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
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        collectionView.backgroundColor = .customBlack
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureDataSource()
        setupView()
        setupTapRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

private extension FilmsViewController {
    
    func setupView() {
        view.backgroundColor = .customBlack
        view.addSubviews([
            searchBar,
            customTitle,
            searchButton,
            collectionView
        ])
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.centerYAnchor.constraint(equalTo: customTitle.centerYAnchor),
            
            searchButton.centerYAnchor.constraint(equalTo: customTitle.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: customTitle.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupTapRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func fetchData() {
        //filmViewModels = NetworkManager.fetchData().map { filmsCellViewModel(film: $0) }
    }
    
    func configureDataSource() {
        
        let cellRegistration = CustomCellRegistration() { cell, _, item in
            //MARK: Update viewmodel
            cell.filmViewModel = item
        }
        
        dataSource = CustomDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: item)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: UICollectionView.elementKindSectionHeader)
        { [unowned self] supplementaryView, elementKind, indexPath in
            
            let videoCategory = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.label.text = videoCategory.rawValue
        }
        
        dataSource.supplementaryViewProvider = { [unowned self] (view, kind, index) in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        applyInitialSnapshot()
    }
    
    func applyInitialSnapshot() {
//        guard let films = filmViewModel.films else {
//            return
//        }
        var snapshot = CustomSnapshot()
        FilmSection.allCases.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems( films.filter { $0.section == section })
        }
        dataSource.apply(snapshot)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let filmSection = FilmSection.allCases[sectionIndex]
            
            var layoutHeight = CGFloat(250)
            var layoutWidth = CGFloat(0.35)
            if filmSection != .popular {
                layoutHeight = 220
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
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                            leading: 20,
                                                            bottom: 0,
                                                            trailing: 20)
            
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
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        
        return layout
    }
    
    func setupSearchBar(hidden: Bool) {
        searchButton.isHidden = !hidden
        customTitle.isHidden = !hidden
        UIView.transition(with: view,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { [unowned self] in
            searchBar.isHidden = hidden
        })
    }
    
    func performQuery(with filter: String) {
        if filter.isEmpty {
            applyInitialSnapshot()
            return
        }
        
        let filteredFilms = filmViewModels.filter { $0.title.contains(filter.lowercased()) }
        
        var snapshot = CustomSnapshot()
        snapshot.appendSections([.popular])
        snapshot.appendItems(filteredFilms)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

private extension FilmsViewController {
    
    @objc func didTapSearchButton() {
        setupSearchButton(hidden: false)
    }
    
    @objc func didTapView() {
        setupSearchButton(hidden: true)
    }
    
}

extension FilmsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
}

extension FilmsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didTapFilmCell()
    }
    
}
