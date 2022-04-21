//
//  FavorisExtension.swift
//  Projet10
//
//  Created by Raphaël Goupille on 15/11/2021.
//

import Foundation

extension Favorite: RecipeToDisplay {
    // Favorite conforme to RecipeToDisplay to have a unique type to display in UI
    var idString: String { uri ?? "" }
    var instructionsUrl: String { url ?? "" }
    var recipeName: String { label ?? "" }
    var recipeImageString: String { image ?? "" }
    var recipeIngredient: String { ingredients ?? "" }
    var cookingTime: Int { Int(totalTime) }
    var recipeCalories: Double { calories }
    
}
