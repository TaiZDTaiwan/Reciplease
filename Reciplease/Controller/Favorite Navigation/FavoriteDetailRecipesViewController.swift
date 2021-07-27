//
//  FavoriteDetailRecipesViewController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 15/07/2021.
//

import UIKit

class FavoriteDetailRecipesViewController: UIViewController {

    // MARK: - Outlets from view
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleRecipeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    var sentChosenFavoriteRecipe = Favorite()
    
    var label: String {
        guard let label = sentChosenFavoriteRecipe.label else { return "" }
            return label
    }
    
    var image: String {
        guard let image = sentChosenFavoriteRecipe.image else { return "" }
            return image
    }
    
    var url: String {
        guard let url = sentChosenFavoriteRecipe.url else { return "" }
            return url
    }
    
    var ingredientLines: [String] {
        guard let ingredientLines = sentChosenFavoriteRecipe.ingredientLines else { return [""] }
            return ingredientLines
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        tableView.register(UINib.init(nibName: DetailRecipesViewController.nibName, bundle: nil), forCellReuseIdentifier: DetailRecipesViewController.cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        insertRecipeImage(urlLabel: image, imageView: recipeImageView)
        titleRecipeLabel.text = label
        checkIfRecipeAlreadyInFavorite()
    }
    
    // MARK: - Methods and Actions dragged from view
    
    private func checkIfRecipeAlreadyInFavorite() {
        if isAlreadyInFavorite() {
            favoriteButton.setImage(#imageLiteral(resourceName: "Selected Favorite Icon"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "Favorite Icon"), for: .normal)
        }
    }
    
    private func isAlreadyInFavorite() -> Bool {
        for recipe in Favorite.all where recipe.label == label {
            return true
        }
        return false
    }
    
    @IBAction func tapGetDirectionsButton(_ sender: UIButton) {
        guard let url = URL(string: url) else {
            presentAlert("No directions available for this recipe.")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIButton) {
        if sender.image(for: .normal) == #imageLiteral(resourceName: "Favorite Icon") {
            sender.setImage(#imageLiteral(resourceName: "Selected Favorite Icon"), for: .normal)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Favorite Icon"), for: .normal)
        }
        addOrRemoveOneFavoriteRecipe()
    }
    
    private func addOrRemoveOneFavoriteRecipe() {
        if isAlreadyInFavorite() {
            for recipe in Favorite.all where recipe.label == label {
                AppDelegate.viewContext.delete(recipe)
            }
        } else {
            let favorite = Favorite(context: AppDelegate.viewContext)
            favorite.label = label
            favorite.image = image
            favorite.url = url
            favorite.ingredientLines = ingredientLines
            try? AppDelegate.viewContext.save()
        }
    }
}

// MARK: - Protocol table view

extension FavoriteDetailRecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecipesViewController.cellId, for: indexPath) as? PresentDetailRecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(ingredientLines: "- " + ingredientLines[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLines.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
