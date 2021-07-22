//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 02/07/2021.
//

import UIKit

class AddIngredientsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets from view

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var fridgeLabel: UILabel!
    @IBOutlet weak var addIngredientsTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet weak var addStackView: UIStackView!
    @IBOutlet weak var clearStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicationLabel: UILabel!
    @IBOutlet weak var handView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    let recipeService = RecipleaseService()
    
    private var ingredientsArray = [String]()
    
    private var recipesArray = [Hits]()
    
    private var listIngredientsToDisplay: String {
        return ingredientsArray.joined(separator: " ")
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchIndicationAnimation()
    }
    
    // MARK: - Methods and Actions dragged from view
    
    private func launchIndicationAnimation() {
        var translationTransform: CGAffineTransform
        translationTransform = CGAffineTransform(translationX: 0, y: 5)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.handView.transform = translationTransform
        }, completion: { (success) in
            if success {
                self.handView.transform = .identity
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDisplayRecipesVC" {
            guard let controller = segue.destination as? DisplayRecipesViewController else {
                self.presentAlert("Navigation error.")
                return
            }
            controller.displayRecipesArray = recipesArray
            
            let backItem = UIBarButtonItem()
            backItem.editBackReturnButonItem(viewController: self)
        }
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        if addIngredientsTextField.hasText {
            guard let ingredient = addIngredientsTextField.text else {
                presentAlert("Please type text before adding an ingredient.")
                return
            }
            ingredientsArray.append(ingredient)
            addIngredientsTextField.text = ""
            tableView.reloadData()
        }
    }
    
    @IBAction func tabClearButton(_ sender: UIButton) {
        ingredientsArray.removeAll()
        tableView.reloadData()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        addIngredientsTextField.resignFirstResponder()
    }
    
    @IBAction func startEditingTextField(_ sender: UITextField) {
        showTableView(shown: true)
    }
    
    @IBAction func finishEditingTextField(_ sender: UITextField) {
        if ingredientsArray.count == 0 && !addIngredientsTextField.hasText {
            showTableView(shown: false)
        } else {
            showTableView(shown: true)
        }
    }
    
    @IBAction func tapSearchForRecipesButton(_ sender: UIButton) {
        if ingredientsArray.count > 0 {
            launchGetRecipeProcess()
            showTableView(shown: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.tableView.reloadData()
                self.performSegue(withIdentifier: "segueToDisplayRecipesVC", sender: nil)
                self.toggleActivityIndicator(shown: false)
            }
        } else {
            self.presentAlert("A recipe cannot be made without ingredients !")
        }
    }
    
    private func launchGetRecipeProcess() {
        toggleActivityIndicator(shown: true)
        
        recipeService.getRecipe(ingredients: listIngredientsToDisplay) { [weak self] success, recipes in
            if success, let recipes = recipes {
                self?.recipesArray = recipes.hits
            } else {
                self?.presentAlert("The recipes download has failed.")
            }
        }
    }
    
    private func showTableView(shown: Bool) {
        indicationLabel.isHidden = shown
        handView.isHidden = shown
        tableView.isHidden = !shown
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchRecipeButton.isHidden = shown
    }
}

// MARK: - Protocol table view

extension AddIngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentIngredientCell", for: indexPath) as? PresentIngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(ingredient: "- " + ingredientsArray[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
        
}
