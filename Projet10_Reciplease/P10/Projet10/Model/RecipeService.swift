//
//  RecipeService.swift
//  Projet10
//
//  Created by Raphaël Goupille on 31/10/2021.
//

import Foundation

class RecipeService {
    
    let session: AlamofireSession
    
    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }
    
    func getRecipe(searchWords: String?, nextPage: String?, callBack: @escaping (Result<RecipeCodable, NetworkError>) -> Void ) {
        
        var stringUrl = ""
        
        if nextPage == nil {
            stringUrl = "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(Constant.appId)&app_key=\(Constant.appKey)&q=\(searchWords!)"
        } else { stringUrl = nextPage! }
        
        guard let url = URL(string: stringUrl) else { return }
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.data else { callBack(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callBack(.failure(.invalidResponse))
                return
            }
            guard let decodedData = try? JSONDecoder().decode(RecipeCodable.self, from: data) else {
                callBack(.failure(.undecodableData))
                return
            }
            callBack(.success(decodedData))
        }
    }
    
}
