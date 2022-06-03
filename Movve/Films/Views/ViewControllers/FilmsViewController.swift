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
    
    typealias ViewModel = FilmsViewModel
    
    var viewModel: ViewModel?
    
    private var dataSource: CustomDataSource!
    private let mainView: FilmsView = FilmsView()
    
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupDelegates()
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
    
    func initialSetup() {
        viewModel?.updateView = {
            DispatchQueue.main.async { [unowned self] in
                configureDataSource()
                applyInitialSnapshot()
            }
        }
        
        viewModel?.fetchData()
    }
    
    func refreshFilms() {
        viewModel?.updateView = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                applyInitialSnapshot()
                mainView.refreshControl.endRefreshing()
            }
        }
        
        viewModel?.fetchData(shuffle: true)
    }
    
    func setupDelegates() {
        mainView.delegate = self
        mainView.collectionView.delegate = self
        mainView.searchBar.delegate = self
    }
    
    func configureDataSource() {
        
        let cellRegistration = CustomCellRegistration() { cell, _, item in
            
            cell.viewModel = item
        }
        
        dataSource = CustomDataSource(collectionView: mainView.collectionView) { collectionView, indexPath, item in
            
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: item)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: UICollectionView.elementKindSectionHeader) {
            [unowned self] supplementaryView, elementKind, indexPath in
            
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.label.text = section.rawValue
        }
        
        dataSource.supplementaryViewProvider = { [unowned self] (view, kind, index) in
            
            mainView.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
    }
    
    func applyInitialSnapshot() {
        guard let viewModel = viewModel,
              let films = viewModel.films else {
            return
        }
        var snapshot = CustomSnapshot()
        FilmSection.allCases.forEach { section in
            if section != .searched {
                snapshot.appendSections([section])
                snapshot.appendItems(films.filter { $0.section == section })
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func performQuery(with filter: String) {
        guard let viewModel = viewModel else {
            return
        }
        
        if filter.isEmpty {
            applyInitialSnapshot()
            return
        }
        
        let filteredFilms = viewModel.searchFilms(by: filter)
        
        var snapshot = CustomSnapshot()
        snapshot.appendSections([.searched])
        snapshot.appendItems(filteredFilms)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension FilmsViewController: FilmsViewDelegate {
    
    func didRefresh() {
        refreshFilms()
    }
    
}

extension FilmsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    
}

extension FilmsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
