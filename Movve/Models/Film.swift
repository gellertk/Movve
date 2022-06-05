//
//  Film.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

struct Film {
    
    let title: String
    var image: Data?
    var actors: [ActorResult: String]?
    var categories: [Category]?
    var releaseDate: Date?
    var duration: String?
    var desc: String?
    var rating: Double?
    var isFavourite: Bool?
    var isStarted: Bool?
    var section: FilmSection?
    
    init(title: String, releaseDate: DateComponents, section: FilmSection) {
        self.title = title
        self.releaseDate = releaseDate.toDate()
        self.section = section
    }

}

struct FilmsProvider {
    
    func fetchData() -> [Film] {
        return [Film(title: "Чудо собака", releaseDate: DateComponents(year: 2010, month: 1, day: 8), section: .popular),
                Film(title: "Чудо кошка", releaseDate: DateComponents(year: 2011, month: 6, day: 1), section: .popular),
                Film(title: "Чудо песик", releaseDate: DateComponents(year: 2019, month: 3, day: 22),  section: .popular),
                Film(title: "Чудо слоник", releaseDate: DateComponents(year: 2019, month: 6, day: 31), section: .popular),
                Film(title: "Чудо крокодильчик", releaseDate: DateComponents(year: 2019, month: 6, day: 5), section: .popular),
                Film(title: "Чудо вуман", releaseDate: DateComponents(year: 2019, month: 4, day: 8), section: .popular),
                
                Film(title: "Про кота  asdasdasdasdasdasdasds", releaseDate: DateComponents(year: 2021, month: 6, day: 8), section: .tvShows),
                Film(title: "Про слона", releaseDate: DateComponents(year: 2019, month: 2, day: 8), section: .tvShows),
                Film(title: "Про бобра", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .tvShows),
                Film(title: "Про муху asdasdasdasdasdasdasds", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .tvShows),
                
                Film(title: "Чудо бублик", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .started),
                Film(title: "Чудо бублик и колобок с пельменями фыв выф", releaseDate: DateComponents(year: 2019, month: 6, day: 8), section: .started)
        ]
    }
    
}

