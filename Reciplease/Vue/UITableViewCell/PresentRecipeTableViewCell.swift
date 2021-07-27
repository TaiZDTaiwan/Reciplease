//
//  PresentRecipeTableViewCell.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 27/07/2021.
//

import UIKit

class PresentRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    func configure(recipe: String, ingredient: [String], url: String) {
        titleRecipeLabel.text = recipe
        
        let textIngredients = ingredient.joined(separator: ", ")
        ingredientsLabel.text = textIngredients
        
        insertRecipeImage(urlLabel: url, imageView: recipeImageView)
        
        let maskLayer = CAGradientLayer(layer: recipeImageView.layer)
        maskLayer.implementShadowLayer(imageView: recipeImageView)
    }
    
    func insertDefaultImage() {
        let defaultURL = URL(string: "https://www.meilleure-note.com/wp-content/uploads/2018/11/meilleur-set-de-couverts.jpg")
        guard let defaultURL = defaultURL else {
            return
        }
        guard let data = try? Data(contentsOf: defaultURL) else {
            return
        }
        recipeImageView.image = UIImage(data: data)
    }
}
