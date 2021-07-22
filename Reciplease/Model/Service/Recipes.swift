//
//  Recipes.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 08/07/2021.
//

import Foundation

// MARK: - API's properties

struct Recipes: Decodable {
    let hits: [Hits]
}

struct Hits: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
}
