//
//  UIImage+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 02.06.2022.
//

import UIKit

extension UIImage {
    
    static var magnifyingglass: UIImage {
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "magnifyingglass",
                                withConfiguration: config) ?? UIImage()
        
        return image
    }
    
    
}
