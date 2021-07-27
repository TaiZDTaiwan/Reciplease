//
//  UITableViewCell+Extensions.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 26/07/2021.
//

import UIKit

extension UITableViewCell {
    func insertRecipeImage(urlLabel: String, imageView: UIImageView) {
        let imageURL = URL(string: urlLabel)
        guard let imageURL = imageURL else {
            insertDefaultImage(imageView)
            return
        }
        guard let data = try? Data(contentsOf: imageURL) else {
            insertDefaultImage(imageView)
            return
        }
        imageView.image = UIImage(data: data)
        
        let maskLayer = CAGradientLayer(layer: imageView.layer)
        maskLayer.implementShadowLayer(imageView: imageView)
    }
    
    private func insertDefaultImage(_ imageView: UIImageView) {
        let defaultURL = URL(string: "https://www.meilleure-note.com/wp-content/uploads/2018/11/meilleur-set-de-couverts.jpg")
        guard let defaultURL = defaultURL else {
            print("Necessary to replace default image.")
            return
        }
        guard let data = try? Data(contentsOf: defaultURL) else {
            print("Necessary to replace default image.")
            return
        }
        imageView.image = UIImage(data: data)
    }
}
