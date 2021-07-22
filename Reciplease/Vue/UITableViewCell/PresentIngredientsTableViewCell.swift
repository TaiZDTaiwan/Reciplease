//
//  PresentIngredientsTableViewCell.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 07/07/2021.
//

import UIKit

class PresentIngredientsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    func configure(ingredient: String) {
        ingredientLabel.text = ingredient
    }
}
