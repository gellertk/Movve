//
//  UINavigationController+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 04.06.2022.
//

import UIKit

extension UINavigationController {
    
    convenience init(rootViewController: UIViewController, prefersLargeTitle: Bool = false) {
        self.init(rootViewController: rootViewController)
        navigationBar.prefersLargeTitles = prefersLargeTitle
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.barStyle = .black
    }
    
}
