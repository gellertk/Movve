//
//  FloatingBarView.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 04.06.2022.
//

import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func didTapBarButton(selectIndex: Int)
}

class FloatingBarView: UIView {
    
    private var tabBarImages: [UIImage] = []
    
    weak var delegate: FloatingBarViewDelegate?
    
    init(with tabBarImages: [UIImage]) {
        self.tabBarImages = tabBarImages
        super.init(frame: .zero)
        setupView()
    }
    
    private lazy var mainStackView: UIStackView = {
        let buttons = tabBarImages.enumerated().map {
            
            createButton(with: $1.applyConfiguration(textStyle: .title1),
                         at: $0)
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons,
                                    axis: .horizontal,
                                    spacing: 0,
                                    distribution: .fillEqually)
        
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }
    
    func setHidden(_ hidden: Bool) {
        isHidden = hidden
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
            self.alpha = hidden ? 0 : 1
            self.transform = hidden ? CGAffineTransform(translationX: 0, y: self.bounds.height) : .identity
        })
    }
    
}

private extension FloatingBarView {
    
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
    
    func createButton(with image: UIImage,
                      at index: Int) -> UIButton {
        let button = UIButton()
        button.tintColor = .customWhite
        button.setImage(image, for: .normal)
        button.setImage(image.fillVersion, for: .selected)
        button.tag = index
        button.addTarget(self, action: #selector(didTapBarButton), for: .touchUpInside)
        button.isSelected = index == 0
        
        return button
    }
    
}

private extension FloatingBarView {
    
    @objc func didTapBarButton(_ sender: UIButton) {
        sender.pulse()
        if !sender.isSelected {
            sender.isSelected = true
            if let buttons = mainStackView.arrangedSubviews as? [UIButton] {
                buttons.forEach {
                    if $0.tag != sender.tag {
                        $0.isSelected = false
                    }
                }
            }
            
            delegate?.didTapBarButton(selectIndex: sender.tag)
        }
    }
    
}


