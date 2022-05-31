//
//  Category.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import Foundation

enum Category: String {
    
    case action = "Action"
    case adventure = "Adventure"
    case comedy = "Comedy"
    case drama = "Drama"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case mystery = "Mystery"
    case romance = "Romance"
    case thriller = "Thriller"
    case western = "Western"
    
}

extension Array where Element == Category {
    
    func toCategoriesString() -> String {
        
        return self.map { $0.rawValue }.joined(separator: ", ")
    }
    
}
