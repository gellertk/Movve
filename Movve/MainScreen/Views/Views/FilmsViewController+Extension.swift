//
//  UIViewController+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 03.06.2022.
//

import UIKit

extension FilmsViewController {
    
    typealias SupplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>
    typealias CellRegistration = UICollectionView.CellRegistration<FilmsCollectionViewCell, FilmViewModel>
    typealias DataSource = UICollectionViewDiffableDataSource<FilmSection, FilmViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FilmSection, FilmViewModel>
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
}
