//
//  SceneDelegate.swift
//  Movve
//
//  Created by Кирилл  Геллерт on 30.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = FilmsViewController()
        window?.makeKeyAndVisible()
    }


}

