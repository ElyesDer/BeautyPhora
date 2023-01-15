//
//  UIViewController+Alert.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 15/01/2023.
//

import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title: String, message: String, action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let primaryAction: UIAlertAction = .init(title: "OK", style: .default) { _ in }
        if let action = action {
            alertController.addAction(action)
        }
        alertController.addAction(primaryAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
