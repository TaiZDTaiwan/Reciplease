//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 02/07/2021.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    // MARK: - Outlets from view
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var indicationLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    // CoreDataManager instance to use its methods.
    private let coreDataManager = CoreDataManager()
    
    // To load and stock the favorite recipes from CoreData.
    private var favoriteRecipes = [FavoriteDataModel]()
    
    // Recipe chosen in table view by user and will be sent in next controller.
    var chosenFavoriteRecipe = FavoriteDataModel()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: DisplayRecipesViewController.nibName, bundle: nil), forCellReuseIdentifier: DisplayRecipesViewController.cellId)
        tableView.rowHeight = DisplayRecipesViewController.cellRowHeight
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoriteRecipes = coreDataManager.favoriteRecipe
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        tableView.reloadData()
        displayOrHideTableView()
    }
    
    // MARK: - Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteDetailRecipesVC" {
            guard let controller = segue.destination as? FavoriteDetailRecipesViewController else {
                self.presentAlert("Navigation error.")
                return
            }
            controller.sentChosenFavoriteRecipe = chosenFavoriteRecipe
            
            editBackReturnButonItem()
        }
    }
    
    private func displayOrHideTableView() {
        if favoriteRecipes.count > 0 {
            showTableView(shown: true)
        } else {
            showTableView(shown: false)
        }
    }
    
    private func showTableView(shown: Bool) {
        indicationLabel.isHidden = shown
        tableView.isHidden = !shown
    }
}

// MARK: - Protocol table view

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DisplayRecipesViewController.cellId, for: indexPath) as? PresentRecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(recipe: favoriteRecipes[indexPath.row].label ?? "", ingredient: favoriteRecipes[indexPath.row].ingredientLines ?? [""], url: favoriteRecipes[indexPath.row].image ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenFavoriteRecipe = favoriteRecipes[indexPath.row]
        self.performSegue(withIdentifier: "segueToFavoriteDetailRecipesVC", sender: nil)
    }
}
