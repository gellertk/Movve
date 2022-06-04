//
//  UIColor+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 01.06.2022.
//

import UIKit

extension UIColor {
    
    static let customBlack = UIColor(red: 24, green: 24, blue: 33)
    static let customWhite = UIColor(red: 216, green: 218, blue: 222)
    static let customGray =  UIColor(red: 89, green: 90, blue: 99)
    static let customRed = UIColor(red: 218, green: 44, blue: 53)
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
}
