//
//  RecipleaseSession.swift
//  Reciplease
//
//  Created by Raphaël Huang-Dubois on 21/07/2021.
//

import Foundation
import Alamofire

// MARK: - Protocol API Networking using Alamofire library.

protocol NetworkRequest {
        
    func request(with url: URL, completionHandler: @escaping (Data?, Error?, HTTPURLResponse?) -> Void)
}

final class RecipleaseSession: NetworkRequest {
        
    func request(with url: URL, completionHandler: @escaping (Data?, Error?, HTTPURLResponse?) -> Void) {
        AF.request(url).responseData { (response: AFDataResponse<Data>) in
            completionHandler(response.data, response.error, response.response)
        }
    }
}
