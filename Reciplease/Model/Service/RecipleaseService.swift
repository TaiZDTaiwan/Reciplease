//
//  RecipleaseService.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 21/07/2021.
//

import Foundation
import Alamofire

class RecipleaseService {
    
    // MARK: - Properties
    
    private let session: NetworkRequest
    private var ingredient = ""
    
    // MARK: - Initialization
    
    init(session: NetworkRequest = RecipleaseSession()) {
        self.session = session
    }
    
    // MARK: - Methods

    func getRecipe(ingredients: String, callback: @escaping (Bool, Recipes?) -> Void) {
        
        ingredient = ingredients
        
        guard let url = URL(string: "https://www.edamam.com/api/recipes/v2?type=public&q=\(ingredient)&app_id=00bc736d&app_key=373deaa6c7662e2beb21afab2609d70b") else {
            return
        }

        session.request(with: url) { (data, error, response) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard let responseJSON = try? JSONDecoder().decode(Recipes.self, from: data) else {
                        callback(false, nil)
                        return
                }
                callback(true, responseJSON)
            }
        }
    }
}
