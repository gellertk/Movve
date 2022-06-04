//
//  UIImage+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 02.06.2022.
//

import UIKit

extension UIImage {
    
    static var house = UIImage(systemName: "house") ?? UIImage()
    static var play = UIImage(systemName: "play.circle") ?? UIImage()
    static var bookmark = UIImage(systemName: "bookmark") ?? UIImage()
    static var person = UIImage(systemName: "person") ?? UIImage()
    
    static var magnifyingglass: UIImage {
        let config = SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "magnifyingglass",
                                withConfiguration: config) ?? UIImage()
        
        return image
    }
    
    func applyConfiguration(textStyle: UIFont.TextStyle) -> UIImage {
        let config = SymbolConfiguration(textStyle: textStyle)
        
        return self.applyingSymbolConfiguration(config) ?? UIImage()
    }
        
}
