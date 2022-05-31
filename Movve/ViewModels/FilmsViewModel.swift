//
//  ViewModel.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

protocol FilmsViewModelProtocol {
    var updateViewData: ((FilmsViewModelProtocol) -> ())? { get set }
    init(films: [Film])
    func didTapFilmCell()
}

struct FilmsViewModel: FilmsViewModelProtocol {
    
    var films: [Film] {
        didSet {
            updateViewData?(self)
        }
    }
    
    var updateViewData: ((FilmsViewModelProtocol) -> ())?
    
    init(films: [Film]) {
        self.films = films
    }
    
    mutating func fetchFilms() {
        films = [Film(title: "Чудо собака", releaseDate: Date(), isStarted: false),
                 Film(title: "Чудо кошка", releaseDate: Date(), isStarted: false),
                 Film(title: "Чудо песик", releaseDate: Date(), isStarted: false),
                 Film(title: "Чудо бобик", releaseDate: Date(), isStarted: false),
                 Film(title: "Чудо копмк", releaseDate: Date(), isStarted: false)
        ]
    }
    
    func didTapFilmCell() {
        
    }
    
}
