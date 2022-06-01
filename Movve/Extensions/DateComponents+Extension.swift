//
//  DateComponents+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 01.06.2022.
//

import Foundation

extension DateComponents {
    
    func toDate() -> Date {
        
        guard let date = DateComponents(calendar: Calendar.current,
                                        year: year,
                                        month: month,
                                        day: day).date else {
            return Date()
        }
        
        return date
    }
    
}

