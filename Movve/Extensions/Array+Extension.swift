//
//  Array+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 01.06.2022.
//

import Foundation

extension Array where Element == Category {
    
    func separate(with separator: String) -> String {
        
        return self.map { $0.rawValue }.joined(separator: separator)
    }
    
}
