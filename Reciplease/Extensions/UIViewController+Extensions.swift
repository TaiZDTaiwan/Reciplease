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
}
