//
//  Film.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

struct Film: Hashable {
    
    var title: String
    var image: Data?
    var actors: [Actor: String]?
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

