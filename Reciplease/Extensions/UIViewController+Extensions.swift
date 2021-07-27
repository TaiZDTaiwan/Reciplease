//
//  UIViewController+Extensions.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 07/07/2021.
//

import UIKit

extension UIViewController {
    func presentAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func editBackReturnButonItem() {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "Back"
        barButtonItem.tintColor = #colorLiteral(red: 0.9450153708, green: 0.945151031, blue: 0.9449856877, alpha: 1)
        navigationItem.backBarButtonItem = barButtonItem
    }
    
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
            presentAlert("Necessary to replace default image.")
            return
        }
        guard let data = try? Data(contentsOf: defaultURL) else {
            presentAlert("Necessary to replace default image.")
            return
        }
        imageView.image = UIImage(data: data)
    }
}
