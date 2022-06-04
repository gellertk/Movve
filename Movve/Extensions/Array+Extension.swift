//
//  Array+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 01.06.2022.
//

import Foundation

extension Array where Element == Category {
    
    func separate(with separator: String) -> String {
        //return driverLicenses.compactMap { $0 }.joined(separator: separator)
        return self.map { $0.rawValue }.joined(separator: separator)
    }
    
}
