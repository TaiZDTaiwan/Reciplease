//
//  UIBarButtonItem+Extensions.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 19/07/2021.
//

import UIKit

extension UIBarButtonItem {
    func editBackReturnButonItem(viewController: UIViewController) {
        title = "Back"
        tintColor = #colorLiteral(red: 0.9450153708, green: 0.945151031, blue: 0.9449856877, alpha: 1)
        viewController.navigationItem.backBarButtonItem = self
    }
}
