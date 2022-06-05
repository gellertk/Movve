//
//  UILabel+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 05.06.2022.
//

import UIKit

extension UILabel {
    
    func changeColor(with textAndColors: [String: UIColor]) {
        var attribute: NSMutableAttributedString?
        for textAndColor in textAndColors {
            guard let text = text else {
                return
            }
            let strNumber = text as NSString
            let range = (strNumber).range(of: textAndColor.key)
            attribute = NSMutableAttributedString(string: text)
            attribute?.addAttribute(NSAttributedString.Key.foregroundColor,
                                    value: textAndColor.value,
                                    range: range)
        }
        
        attributedText = attribute
    }
    
}
