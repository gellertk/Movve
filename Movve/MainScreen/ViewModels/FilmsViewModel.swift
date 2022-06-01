//
//  ViewModel.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

//protocol FilmsViewModelProtocol {
//    var updateViewData: ((FilmsViewModelProtocol) -> ())? { get set }
//    init(films: [Film])
//    func didTapFilmCell()
//}

struct NetworkManager {
    
    static func fetchData() -> [Film] {
        return [Film(title: "Чудо собака", releaseDate: DateComponents(year: 2010, month: 1, day: 8), section: .popular),
                Film(title: "Чудо кошка", releaseDate: DateComponents(year: 2011, month: 6, day: 1), section: .popular),
                Film(title: "Чудо песик", releaseDate: DateComponents(year: 2019, month: 3, day: 22),  section: .popular),
                Film(title: "Чудо слоник", releaseDate: DateComponents(year: 2019, month: 6, day: 31), section: .popular),
                Film(title: "Чудо крокодильчик", releaseDate: DateComponents(year: 2019, month: 6, day: 5), section: .popular),
                Film(title: "Чудо вуман", releaseDate: DateComponents(year: 2019, month: 4, day: 8), section: .popular),

                Film(title: "Про кота", releaseDate: DateComponents(year: 2021, month: 6, day: 8), section: .tvShows),
                Film(title: "Про слона", releaseDate: DateComponents(year: 2019, month: 2, day: 8), section: .tvShows),
                Film(title: "Про бобра", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .tvShows),
                Film(title: "Про муху", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .tvShows),

                Film(title: "Чудо бублик", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .started)
        ]
    }
    
}

struct FilmViewModel: Hashable {
    
    let title: String
    let image: Data?
    let releaseDate: String
    let section: FilmSection
    
    //    var film: Film {
    //        didSet {
    //            //updateViewData?(self)
    //        }
    //    }
    
    //    var updateViewData: ((FilmsViewModelProtocol) -> ())?
    
    init(film: Film) {
        self.image = film.image
        self.title = film.title
        self.releaseDate = film.releaseDate?.toMMMDYYY() ?? ""
        self.section = film.section ?? .started
    }
    
}
