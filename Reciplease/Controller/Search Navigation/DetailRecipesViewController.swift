//
//  DetailRecipesViewController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 12/07/2021.
//

import UIKit

class DetailRecipesViewController: UIViewController {
    
    // MARK: - Outlets from view
    
    @IBOutlet weak private var recipeImageView: UIImageView!
    @IBOutlet weak private var titleRecipeLabel: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var getDirectionsButton: UIButton!
    @IBOutlet weak private var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    // Statics to prepare custom nib for table view.
    static let nibName = "PresentDetailRecipeTableViewCell"
    static let cellId = "PresentDetailRecipeCell"
    
    // CoreDataManager instance to use its methods.
    private let coreDataManager = CoreDataManager()
    
    // Received recipe from previous controller.
    var chosenRecipeToDetail: Hits?
    
    private var label: String {
        guard let chosenRecipeToDetail = chosenRecipeToDetail else { return "" }
        return chosenRecipeToDetail.recipe.label
    }
    
    private var image: String {
        guard let chosenRecipeToDetail = chosenRecipeToDetail else { return "" }
        return chosenRecipeToDetail.recipe.image
    }
    
    private var url: String {
        guard let chosenRecipeToDetail = chosenRecipeToDetail else { return "" }
        return chosenRecipeToDetail.recipe.url
    }
    
    private var ingredientLines: [String] {
        guard let chosenRecipeToDetail = chosenRecipeToDetail else { return [""] }
        return chosenRecipeToDetail.recipe.ingredientLines
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: DetailRecipesViewController.nibName, bundle: nil), forCellReuseIdentifier: DetailRecipesViewController.cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let chosenRecipeToDetail = chosenRecipeToDetail {
            insertRecipeImage(urlLabel: "\(chosenRecipeToDetail.recipe.image)", imageView: recipeImageView)
            titleRecipeLabel.text = chosenRecipeToDetail.recipe.label
        }
        checkIfRecipeAlreadyInFavorite()
    }
    
    // MARK: - Methods and Actions dragged from view
    
    // To assign the right star icon color.
    private func checkIfRecipeAlreadyInFavorite() {
        if coreDataManager.checkIfRecipeAlreadyInFavorite(label: label) {
            favoriteButton.setImage(#imageLiteral(resourceName: "Selected Favorite Icon"), for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "Favorite Icon"), for: .normal)
        }
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
            coreDataManager.addOneFavoriteRecipe(label: label, image: image, url: url, ingredientLines: ingredientLines)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Favorite Icon"), for: .normal)
            coreDataManager.removeOneFavoriteRecipe(label: label)
        }
    }
}

// MARK: - Protocol table view

extension DetailRecipesViewController: UITableViewDataSource {
    
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
