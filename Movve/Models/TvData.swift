//
//  TvData.swift
//  Movve
//
//  Created by Fed on 04.06.2022.
//

import Foundation


struct TvData: Codable {
    
    let results: [TvResult]
}

struct TvResult: Codable {
    
    let original_name: String        //название сериала
    let original_language: String   //язык сериала
    let overview: String            //кратское описание сериала
    let vote_average: Double        // оценка сериала
    let first_air_date: String      // дата выхода
    let id: Int                     // id сериала
    let poster_path: String        // путь к картинке
}
