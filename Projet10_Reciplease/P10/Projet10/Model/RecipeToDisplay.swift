//
//  RecipeToDisplay.swift
//  Projet10
//
//  Created by Raphaël Goupille on 01/11/2021.
//

import Foundation
import UIKit

// protocol to have a unique type to display in UI
protocol RecipeToDisplay {
    var idString: String { get }
    var instructionsUrl: String { get }
    var recipeName: String { get }
    var recipeImageString: String { get }
    var recipeIngredient: String { get }
    var cookingTime: Int { get }
    var recipeCalories: Double { get }

}
