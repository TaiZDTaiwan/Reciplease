//
//  Favorite.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 21/07/2021.
//

import CoreData

class Favorite: NSManagedObject {
    static var all: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        guard let favorite = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favorite
    }
}
