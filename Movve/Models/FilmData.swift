//
//  FilmData.swift
//  Movve
//
//  Created by Fed on 04.06.2022.
//

import Foundation

struct FilmData: Codable {
    
    let resulsts: [FilmResult]
}

struct FilmResult: Codable {
    
    let original_title: String      // название фильма
    let original_language: String   // язык фильма
    let overview: String            // описание фильма
    let release_date: String        // дата выхода фильма
    let vote_average: Double        // средняя оценка фильма
    let id: Int                    // по ID подтягиваются актеры фильма
    let poster_path: String        // путь к картинке
}
