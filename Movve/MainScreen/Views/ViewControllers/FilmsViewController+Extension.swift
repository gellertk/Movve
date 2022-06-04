//
//  UIViewController+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 03.06.2022.
//

import UIKit

extension FilmsViewController {
    
    typealias CustomCellRegistration = UICollectionView.CellRegistration<FilmsCollectionViewCell, FilmViewModel>
    typealias CustomDataSource = UICollectionViewDiffableDataSource<FilmSection, FilmViewModel>
    typealias CustomSnapshot = NSDiffableDataSourceSnapshot<FilmSection, FilmViewModel>
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
}
