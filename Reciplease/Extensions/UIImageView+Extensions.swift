//
//  UIImageView+Extensions.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 19/07/2021.
//

import UIKit

extension UIImageView {
    
    func insertRecipeImage(urlLabel: String, viewController: UIViewController) {
        let imageURL = URL(string: urlLabel)
        guard let imageURL = imageURL else {
            insertDefaultImage(viewController: viewController)
            return
        }
        guard let data = try? Data(contentsOf: imageURL) else {
            insertDefaultImage(viewController: viewController)
            return
        }
        image = UIImage(data: data)
        
        let maskLayer = CAGradientLayer(layer: self.layer)
        maskLayer.implementShadowLayer(imageView: self)
    }
    
    private func insertDefaultImage(viewController: UIViewController) {
        let defaultURL = URL(string: "https://www.meilleure-note.com/wp-content/uploads/2018/11/meilleur-set-de-couverts.jpg")
        guard let defaultURL = defaultURL else {
            viewController.presentAlert("Necessary to replace default image.")
            return
        }
        guard let data = try? Data(contentsOf: defaultURL) else {
            viewController.presentAlert("Necessary to replace default image.")
            return
        }
        image = UIImage(data: data)
    }
}
