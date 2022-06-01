//
//  Film.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

//enum FilmsViewData {
//    
//    case initial
//    case loading([Film])
//    case success([Film])
//    case failure([Film])
//    
//    
//    
//}

struct Film {
    
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
    
//    init(title: String, image: Data?, actors: [Actor : String], categories: [Category], releaseDate: Date, duration: String, desc: String, rating: Double, isFavourite: Bool, isStarted: Bool) {
//        self.title = title
//        self.image = image
//        self.actors = actors
//        self.categories = categories
//        self.releaseDate = releaseDate
//        self.duration = duration
//        self.desc = desc
//        self.rating = rating
//        self.isFavourite = isFavourite
//        self.isStarted = isStarted
//    }

}

