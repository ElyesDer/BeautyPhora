//
//  SceneDelegate.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var factory: ViewModelFactory = .init()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let homeViewController = HomeViewController(viewModel: factory.buildHomeViewModel())
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = homeViewController
        self.window = window
        
        window.makeKeyAndVisible()
    }
}
