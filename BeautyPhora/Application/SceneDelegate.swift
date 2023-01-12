//
//  SceneDelegate.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let homeViewController = HomeViewController()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: homeViewController)
        self.window = window
        
        window.makeKeyAndVisible()
    }
}