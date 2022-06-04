//
//  FilmsViewController.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

class FilmsViewController: UIViewController {
        
    typealias ViewModel = FilmsViewModel
    
    var viewModel: ViewModel?
    
    private var dataSource: CustomDataSource!
    private let mainView = FilmsView()
    
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
        setTabBarHidden(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setTabBarHidden(true)
    }
    
    private func setTabBarHidden(_ hidden: Bool) {
        guard let tabBar = tabBarController as? MainTabBarController else {
            return
        }
        tabBar.setHidden(hidden)
    }
    
}

private extension FilmsViewController {
    
    func initialSetup() {
        extendedLayoutIncludesOpaqueBars = true
        title = "Movve"
        let rightButton = UIButton()
        rightButton.setImage(.magnifyingglass, for: .normal)
            //rightButton.setTitle("Right Button", for: .normal)
            rightButton.setTitleColor(.purple, for: .normal)
            rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
            navigationController?.navigationBar.addSubview(rightButton)
            rightButton.tag = 1
            rightButton.frame = CGRect(x: self.view.frame.width, y: 0, width: 120, height: 20)

            let targetView = self.navigationController?.navigationBar

            let trailingContraint = NSLayoutConstraint(item: rightButton, attribute:
                .trailingMargin, relatedBy: .equal, toItem: targetView,
                                 attribute: .trailingMargin, multiplier: 1.0, constant: -16)
            let bottomConstraint = NSLayoutConstraint(item: rightButton, attribute: .bottom, relatedBy: .equal,
                                            toItem: targetView, attribute: .bottom, multiplier: 1.0, constant: -10)
            rightButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([trailingContraint, bottomConstraint])
        viewModel?.updateView = {
            DispatchQueue.main.async { [unowned self] in
                configureDataSource()
                applySnapshot()
            }
        }
        
        viewModel?.fetchData()
    }
    
    @objc func rightButtonTapped() {
        //navigationItem.searchController = mainView.searchController
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
        mainView.searchController.searchResultsUpdater = self
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
    
    func applySnapshot() {
        guard let films = viewModel?.films else {
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
            applySnapshot()
            return
        }
        
        let filteredFilms = viewModel.searchFilms(by: filter)
        
        var snapshot = CustomSnapshot()
        snapshot.appendSections([.searched])
        snapshot.appendItems(filteredFilms)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension FilmsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        performQuery(with: text)
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
