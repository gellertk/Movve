//
//  UIButton+Extension.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 05.06.2022.
//

import UIKit

extension UIButton {

    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}
