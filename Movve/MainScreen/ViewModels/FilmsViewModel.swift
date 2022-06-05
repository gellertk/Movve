//
//  ViewModel.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

protocol FilmsViewModelProtocol {
    var updateView: (() -> Void)? { get }
    var films: [FilmViewModel]? { get }
    var filmsProvider: FilmsProvider { get }
    var isSearchMode: Bool { get }
    init(filmsProvider: FilmsProvider)
    mutating func fetchData(shuffle: Bool)
    func searchFilms(by filter: String) -> [FilmViewModel]
}

struct FilmsViewModel: FilmsViewModelProtocol {
    
    var updateView: (() -> Void)?
    
    var films: [FilmViewModel]? {
        didSet {
            updateView?()
        }
    }
    
    var filmsProvider: FilmsProvider
    var isSearchMode: Bool
    
    init(filmsProvider: FilmsProvider) {
        self.filmsProvider = filmsProvider
        isSearchMode = false
    }
    
    mutating func fetchData(shuffle: Bool = false) {
        films = filmsProvider.fetchData().map { FilmViewModel(film: $0) }
        if shuffle {
            films?.shuffle()
        }
    }
    
    mutating func setSearchMode(_ searched: Bool) {
        isSearchMode = searched
    }
    
    func searchFilms(by filter: String) -> [FilmViewModel] {
        if let films = films {
            
            var findedFilms = films.filter { $0.title.contains(filter.capitalizingFirstLetter()) || $0.title.contains(filter.lowercased()) }
            for index in findedFilms.indices {
                findedFilms[index].imageHeightConstant = K.Numeric.hightSectionImageHeight
            }
            
            return findedFilms
        }
        
        return []
    }
    
}


