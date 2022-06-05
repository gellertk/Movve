//
//  FilmsViewController.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

class FilmsViewController: UIViewController {
    
    private let mainView = FilmsView()
    
    private var viewModel: FilmsViewModel?
    private var dataSource: DataSource!
        
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: FilmsViewModel) {
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
        setTabBarHidden(false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setTabBarHidden(true)
    }
        
}

private extension FilmsViewController {
    
    func initialSetup() {
        setupNavigationBar()
        viewModel?.updateView = {
            DispatchQueue.main.async { [unowned self] in
                configureDataSource()
                applySnapshot()
            }
        }
        viewModel?.fetchData()
    }
    
    func setupNavigationBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        extendedLayoutIncludesOpaqueBars = true
        title = "Movve"
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.setRightBarButton(mainView.searchButton,
                                             animated: false)
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func setSearchBarHidden(_ shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        navigationItem.titleView = shouldShow ? mainView.searchBar : nil
    }

    func refreshFilms() {
        
        viewModel?.updateView = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                applySnapshot()
                DispatchQueue.main.async { [unowned self] in
                    mainView.collectionView.refreshControl?.endRefreshing()
                }
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
        
        let cellRegistration = CellRegistration() { cell, _, item in
            
            cell.viewModel = item
        }
        
        dataSource = DataSource(collectionView: mainView.collectionView) {
            collectionView, indexPath, item in
            
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: item)
        }
        
        let supplementaryRegistration = SupplementaryRegistration(elementKind:
                                                                  UICollectionView.elementKindSectionHeader) {
            [unowned self] (supplementaryView,
                            elementKind,
                            indexPath) in
            
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            supplementaryView.label.text = section.rawValue
        }
        
        dataSource.supplementaryViewProvider = { [unowned self] (view, kind, index) in
            
            mainView.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
    }
    
    func applySnapshot() {
        guard let films = viewModel?.films else {
            return
        }
        var snapshot = Snapshot()
        FilmSection.allCases.forEach { section in
            if section != .searched {
                snapshot.appendSections([section])
                snapshot.appendItems(films.filter { $0.section == section })
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func performQuery(_ filter: String) {

        if filter.isEmpty {
            viewModel?.setSearchMode(false)
            applySnapshot()
            return
        }
        
        viewModel?.setSearchMode(true)
        let filteredFilms = viewModel?.searchFilms(by: filter)
        
        if let filteredFilms = filteredFilms {
            var snapshot = Snapshot()
            snapshot.appendSections([.searched])
            snapshot.appendItems(filteredFilms)
            dataSource.apply(snapshot, animatingDifferences: true)
        }

        //mainView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setTabBarHidden(_ hidden: Bool) {
        guard let tabBar = tabBarController as? MainTabBarController else {
            return
        }
        tabBar.setHidden(hidden)
    }
    
}

extension FilmsViewController: FilmsViewDelegate {

    func didRefreshFilms() {
        refreshFilms()
    }
    
    func didTapSearchButton() {
        setSearchBarHidden(true)
    }
    
    func isSearchMode() -> Bool? {
        return viewModel?.isSearchMode
    }
    
}

extension FilmsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setTabBarHidden(false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setTabBarHidden(false)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            setTabBarHidden(true)
        }
        else{
            setTabBarHidden(false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            setTabBarHidden(true)
        }
    }
    
}

extension FilmsViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        setSearchBarHidden(false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(searchText)
    }
    
}

extension FilmsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
