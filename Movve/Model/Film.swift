//
//  Film.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

struct Film {
    
    let title: String
    let image: URL
    let actors: [Actor: String]
    let categorys: [Category]
    let releaseDate: Date
    let duration: String
    let desc: String
    var rating: Double
    var isFavourite: Bool
    var isStarted: Bool

    
}
