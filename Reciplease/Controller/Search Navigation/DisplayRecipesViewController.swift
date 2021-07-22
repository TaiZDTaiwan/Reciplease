//
//  DisplayRecipesViewController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 09/07/2021.
//

import UIKit

class DisplayRecipesViewController: UIViewController {
    
    // MARK: - Outlets from view
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var displayRecipesArray = [Hits]()
    var chosenRecipeFromTableView: Hits!
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Methods and Actions dragged from view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailRecipesVC" {
            guard let controller = segue.destination as? DetailRecipesViewController else {
                self.presentAlert("Navigation error.")
                return
            }
            let backItem = UIBarButtonItem()
            backItem.editBackReturnButonItem(viewController: self)
            
            controller.chosenRecipeToDetail = chosenRecipeFromTableView
        }
    }
}

// MARK: - Protocol table view

extension DisplayRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentRecipeCell", for: indexPath) as? PresentRecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(recipe: displayRecipesArray[indexPath.row].recipe.label, ingredient: displayRecipesArray[indexPath.row].recipe.ingredientLines, url: displayRecipesArray[indexPath.row].recipe.image, viewController: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRecipesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenRecipeFromTableView = displayRecipesArray[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetailRecipesVC", sender: nil)
    }
}
