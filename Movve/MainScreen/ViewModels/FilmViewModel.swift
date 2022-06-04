//
//  FilmViewModel.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 03.06.2022.
//

import UIKit

protocol FilmViewModelProtocol: Hashable {
    var title: String { get }
    var image: Data? { get }
    var releaseDate: String { get }
    var section: FilmSection { get }
    var imageHeightConstant: CGFloat { get }
    init(film: Film)
}

struct FilmViewModel: FilmViewModelProtocol {
    
    let title: String
    let image: Data?
    let releaseDate: String
    let section: FilmSection
    var imageHeightConstant: CGFloat
    
    init(film: Film) {
        self.image = film.image
        self.title = film.title
        self.releaseDate = film.releaseDate?.toMMMDYYY() ?? ""
        self.section = film.section ?? .started
        self.imageHeightConstant = section == .popular ?
                                                K.Numeric.hightSectionImageHeight
                                                : K.Numeric.lowSectionImageHeight
    }
    
}
