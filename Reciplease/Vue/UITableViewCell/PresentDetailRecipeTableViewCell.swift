//
//  PresentDetailRecipeTableViewCell.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 12/07/2021.
//

import UIKit

class PresentDetailRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLinesLabel: UILabel!
    
    func configure(ingredientLines: String) {
        ingredientLinesLabel.text = ingredientLines
    }
}
