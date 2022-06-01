//
//  FilmsViewController.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

extension FilmsViewController {
    
    typealias CustomCellRegistration = UICollectionView.CellRegistration<FilmCollectionViewCell, FilmViewModel>
    typealias CustomDataSource = UICollectionViewDiffableDataSource<FilmSection, FilmViewModel>
    typealias CustomSnapshot = NSDiffableDataSourceSnapshot<FilmSection, FilmViewModel>
    
}

class FilmsViewController: UIViewController {
    
    private var filmViewModels: [FilmViewModel] = []
    private var dataSource: CustomDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureDataSource()
        setupView()
    }
    
    func fetchData() {
        filmViewModels = NetworkManager.fetchData().map { FilmViewModel(film: $0) }
    }
        
    func configureDataSource() {
        
        let cellRegistration = CustomCellRegistration() { cell, indexPath, item in
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
        var snapshot = CustomSnapshot()
        FilmSection.allCases.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(filmViewModels.filter { $0.section == section })
        }
        dataSource.apply(snapshot)
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .customBlack
        
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int,
                                 layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                   heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20)
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(44))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: titleSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        
        return layout
    }
    
}

private extension FilmsViewController {
    
    func setupView() {
        view.backgroundColor = .customBlack
        view.addSubviews([collectionView])
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension FilmsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didTapFilmCell()
    }
    
}
