//
//  CoreDataManagerTestCase.swift
//  RecipleaseTests
//
//  Created by Raphaël Huang-Dubois on 29/07/2021.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataManagerTestCase: XCTestCase {
    
    var coreDataStack: CoreDataTestStack!
    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        coreDataManager = CoreDataManager(mainContext: coreDataStack.mainContext)
    }
    
    func testGivenFunctionAddOneFavoriteRecipe_WhenUsingFunction_ThenShouldBeCorrectlySavedInFavorite() {
        coreDataManager.addOneFavoriteRecipe(label: "Chicken Vesuvio", image: "", url: "", ingredientLines: [""])
        XCTAssertTrue(coreDataManager.favoriteRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoriteRecipe[0].label! == "Chicken Vesuvio")
    }
    
    func testGivenOneRecipeAddedInFavorite_WhenUsingFunctionRemoveOneFavoriteRecipe_ThenShouldBeCorrectlyRemovedFromFavorite() {
        coreDataManager.addOneFavoriteRecipe(label: "Chicken Vesuvio", image: "", url: "", ingredientLines: [""])
        coreDataManager.removeOneFavoriteRecipe(label: "Chicken Vesuvio")
        XCTAssertTrue(coreDataManager.favoriteRecipe.isEmpty)
    }
    
    func testGivenOneRecipeAddedInFavorite_WhenUsingFunctionCheckIfRecipeAlreadyInFavorite_ThenShouldReturnTrue() {
        coreDataManager.addOneFavoriteRecipe(label: "Chicken Vesuvio", image: "", url: "", ingredientLines: [""])
        XCTAssertTrue(coreDataManager.checkIfRecipeAlreadyInFavorite(label: "Chicken Vesuvio"))
    }
}
