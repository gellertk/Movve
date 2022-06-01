//
//  UIView+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 01.06.2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
}
