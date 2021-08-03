//
//  RecipleaseTestCase.swift
//  RecipleaseTests
//
//  Created by Raphaël Huang-Dubois on 23/07/2021.
//

import XCTest
@testable import Reciplease

class RecipleaseTestCase: XCTestCase {
    
    func testGetRecipeRateShouldPostFailedCallbackIfError() {
        
        // Given
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        reciplease.getRecipe(ingredients: "lemon") { (success, recipes) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(recipes)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfNoData() {
        
        // Given
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        reciplease.getRecipe(ingredients: "lemon") { (success, recipes) in

        // Then
        XCTAssertFalse(success)
        XCTAssertNil(recipes)
        expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: FakeResponseData.recipleaseCorrectData, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        reciplease.getRecipe(ingredients: "lemon") { (success, recipes) in
        
        // Then
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        reciplease.getRecipe(ingredients: "lemon") { (success, recipes) in
            
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(recipes)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: FakeResponseData.recipleaseCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        reciplease.getRecipe(ingredients: "lemon, cucumber, fish, curry, pickles") { (success, recipes) in
            
        // Then
        let label = "Fish tikka skewers with chapati and pickled cucumber"
            
        XCTAssertTrue(success)
        XCTAssertNotNil(recipes)
        XCTAssertEqual(label, recipes?.hits[0].recipe.label)
        expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
}
