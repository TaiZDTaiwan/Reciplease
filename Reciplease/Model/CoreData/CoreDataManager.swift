//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 30/07/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Properties
    
    var mainContext: NSManagedObjectContext
    
    var favoriteRecipe: [FavoriteDataModel] {
        let request: NSFetchRequest = FavoriteDataModel.fetchRequest()
        do {
           return try mainContext.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Initialization
    
    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    // MARK: - Methods
    
    // method to add recipe in Favorites
    func addOneFavoriteRecipe(label: String, image: String, url: String, ingredientLines: [String]) {
        
        let recipe = FavoriteDataModel(context: mainContext)
        recipe.label = label
        recipe.image = image
        recipe.url = url
        recipe.ingredientLines = ingredientLines
        
        saveContext()
    }
    
    // method to remove recipe in Favorites
    func removeOneFavoriteRecipe(label: String) {
        let request: NSFetchRequest<FavoriteDataModel> = FavoriteDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        if let result = try? mainContext.fetch(request) {
            for object in result {
                mainContext.delete(object)
            }
        }
    }
    
    // method to check if recipe is already in Favorites
    func checkIfRecipeAlreadyInFavorite(label: String) -> Bool {
        let request: NSFetchRequest<FavoriteDataModel> = FavoriteDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        guard let recipes = try? mainContext.fetch(request) else { return false }
        if recipes.isEmpty { return false }
        return true
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
