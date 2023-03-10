//
//  UIImageView+Loader.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import UIKit

// thanks to: https://stackoverflow.com/a/37019507/5354067

extension UIImageView {
    func imageFromServerURL(_ url: URL, placeHolder: UIImage?) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    self.image = downloadedImage
                } else {
                    self.image = placeHolder
                }
            }
        }).resume()
    }
}
