//
//  Date+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 31.05.2022.
//

import UIKit

extension Date {
    
    func toMMMDYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: self)
    }
    
}
