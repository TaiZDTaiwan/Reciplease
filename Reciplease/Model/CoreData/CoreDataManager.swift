//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 30/07/2021.
//

import Foundation
import CoreData

// Class with all the logical methods related to CoreData with CoreDataStack's view context as main context.

class CoreDataManager {
    
    // MARK: - Properties
    
    private var mainContext: NSManagedObjectContext
    
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
    
    func addOneFavoriteRecipe(label: String, image: String, url: String, ingredientLines: [String]) {
        let recipe = FavoriteDataModel(context: mainContext)
        recipe.label = label
        recipe.image = image
        recipe.url = url
        recipe.ingredientLines = ingredientLines
        
        saveContext()
    }
    
    func removeOneFavoriteRecipe(label: String) {
        let request: NSFetchRequest<FavoriteDataModel> = FavoriteDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        if let result = try? mainContext.fetch(request) {
            for object in result {
                mainContext.delete(object)
            }
        } else {
            print("Impossible to remove a recipe.")
        }
    }
    
    func checkIfRecipeAlreadyInFavorite(label: String) -> Bool {
        let request: NSFetchRequest<FavoriteDataModel> = FavoriteDataModel.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", label)
        
        guard let recipes = try? mainContext.fetch(request) else {
            print("Impossible to check recipes existence in favorite.")
            return false
        }
        if recipes.isEmpty {
            return false
        }
        return true
    }
    
    private func saveContext() {
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
