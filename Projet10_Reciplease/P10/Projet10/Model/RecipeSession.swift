//
//  RecipeSession.swift
//  Projet10
//
//  Created by Raphaël Goupille on 16/11/2021.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}

class RecipeSession: AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
    
}
