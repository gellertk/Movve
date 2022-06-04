//
//  FloatingBarView.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 04.06.2022.
//

import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func didTabBarButton(selectindex: Int)
}

class FloatingBarView: UIView {

    weak var delegate: FloatingBarViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    private lazy var mainStackView: UIStackView = {
        let tabBarImages: [UIImage] = [.house,
                                       .play,
                                       .bookmark,
                                       .person]
        
       let buttons = tabBarImages.enumerated().map {
        
           createButton(with: $1.applyConfiguration(textStyle: .title1), at: $0)
       }
        
       let stackView = UIStackView(arrangedSubviews: buttons,
                                   axis: .horizontal,
                                   spacing: 30,
                                   distribution: .fillEqually)
        
        return stackView
    }()
    
    func setupView() {
        backgroundColor = .customRed
        addSubviews([mainStackView])
        setupConstraint()
    }

    func setupConstraint() {
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -16)
        ])
    }
    
    func createButton(with image: UIImage, at index: Int) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .customWhite
        //image = image.applyConfiguration(textStyle: .largeTitle)
        button.setImage(image, for: .normal)
        button.tag = index
        button.addTarget(self, action: #selector(didTabBarButton), for: .touchUpInside)
        
        return button
    }

    @objc func didTabBarButton(_ sender: UIButton) {
        //sender.pulse()
        delegate?.didTabBarButton(selectindex: sender.tag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setHidden(_ hidden: Bool) {
        if !hidden {
            isHidden = hidden
        }

        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = hidden ? 0 : 1
            self.transform = hidden ? CGAffineTransform(translationX: 0, y: 10) : .identity
        }) { (_) in
            if hidden {
                self.isHidden = hidden
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }
    
}

extension UIButton {

    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}
