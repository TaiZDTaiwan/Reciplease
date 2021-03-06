//
//  DisplayRecipesViewController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 09/07/2021.
//

import UIKit

class DisplayRecipesViewController: UIViewController {
    
    // MARK: - Outlets from view
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var indicationLabel: UILabel!
    
    // MARK: - Properties
    
    // Statics to prepare custom nib for table view.
    static let nibName = "PresentRecipeTableViewCell"
    static let cellId = "PresentRecipeCell"
    static let cellRowHeight: CGFloat = 180
    
    // Received recipes from previous controller.
    var displayRecipesArray = [Hits]()
    
    // Recipe chosen in table view by user and will be sent in next controller.
    var chosenRecipe: Hits?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: DisplayRecipesViewController.nibName, bundle: nil), forCellReuseIdentifier: DisplayRecipesViewController.cellId)
        tableView.rowHeight = DisplayRecipesViewController.cellRowHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkRecipesAvailability()
    }
    
    // MARK: - Methods and Actions dragged from view
    
    private func checkRecipesAvailability() {
        if displayRecipesArray.count > 0 {
            tableView.reloadData()
        } else {
            indicationLabel.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailRecipesVC" {
            guard let controller = segue.destination as? DetailRecipesViewController else {
                self.presentAlert("Navigation error.")
                return
            }
            
            guard let chosenRecipe = chosenRecipe else {
                self.presentAlert("Impossible to access this recipe details.")
                return
            }
            controller.chosenRecipeToDetail = chosenRecipe
            
            editBackReturnButonItem()
        }
    }
}

// MARK: - Protocol table view

extension DisplayRecipesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DisplayRecipesViewController.cellId, for: indexPath) as? PresentRecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(recipe: displayRecipesArray[indexPath.row].recipe.label, ingredient: displayRecipesArray[indexPath.row].recipe.ingredientLines, url: displayRecipesArray[indexPath.row].recipe.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRecipesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenRecipe = displayRecipesArray[indexPath.row]
        self.performSegue(withIdentifier: "segueToDetailRecipesVC", sender: nil)
    }
}
