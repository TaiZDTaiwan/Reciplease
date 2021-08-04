//
//  NavigationController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 05/07/2021.
//

import UIKit

// To design the navigation bar title.

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 25)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9450153708, green: 0.945151031, blue: 0.9449856877, alpha: 1)]
    }
}
