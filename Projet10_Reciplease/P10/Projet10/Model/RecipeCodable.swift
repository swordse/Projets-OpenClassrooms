//
//  RecipeCodable.swift
//  Projet10
//
//  Created by Raphaël Goupille on 31/10/2021.
//

import Foundation
import UIKit

// MARK: - RecipeCodable
struct RecipeCodable: Codable {
    let count: Int
    let recipes: [Recipe]
    let links: WelcomeLinks
    
    enum CodingKeys: String, CodingKey {
        case recipes = "hits"
        case count
        case links = "_links"
    }
}
// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let next: Next
}
// MARK: - Next
struct Next: Codable {
    let href: String
}

// MARK: - Recipe
struct Recipe: Codable {
    let recipe: Detail
}

// MARK: - Detail
struct Detail: Codable {
    let uri: String
    let url: String
    let label: String
    let image: String
    let ingredientLines: [String]
    let totalTime: Int
    let calories: Double
    
    init(uri: String, url: String, label: String, image: String, ingredientLines: [String], totalTime: Int, calories: Double) {
        self.uri = uri
        self.url = url
        self.label = label
        self.image = image
        self.ingredientLines = ingredientLines
        self.totalTime = totalTime
        self.calories = calories
    }
}
// conform to protocol RecipeToDisplay to have a unique type to display in UI
extension Detail: RecipeToDisplay {
    var idString: String { uri }
    var instructionsUrl: String { url }
    var recipeName: String { label }
    var recipeImageString: String { image }
    var recipeIngredient: String { ingredientLines.joined(separator: ", ") }
    var cookingTime: Int { totalTime }
    var recipeCalories: Double { calories }
    
}

