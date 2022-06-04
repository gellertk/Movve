//
//  MainTabBarController.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 04.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    private lazy var mainView = FloatingBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialViewModel = FilmsViewModel(filmsProvider: FilmsProvider())
        
        viewControllers = [
            UINavigationController(rootViewController: FilmsViewController(viewModel: initialViewModel), prefersLargeTitle: true),
            UINavigationController(rootViewController: FilmsViewController(viewModel: initialViewModel), prefersLargeTitle: true),
            UINavigationController(rootViewController: FilmsViewController(viewModel: initialViewModel), prefersLargeTitle: true),
            UINavigationController(rootViewController: FilmsViewController(viewModel: initialViewModel), prefersLargeTitle: true)
        ]
        tabBar.isHidden = true

        setupView()
    }
    
    func setHidden(_ hidden: Bool) {
        mainView.setHidden(hidden)
    }
}

private extension MainTabBarController {
    
    func setupView() {
        view.addSubviews([mainView])
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -50),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: 20),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -20),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                             multiplier: 0.08)
        ])
    }
    
    func setupDelegates() {
        mainView.delegate = self
    }
    
}

extension MainTabBarController: FloatingBarViewDelegate {
    
    func didTabBarButton(selectindex: Int) {
        selectedIndex = selectindex
    }
    
}

