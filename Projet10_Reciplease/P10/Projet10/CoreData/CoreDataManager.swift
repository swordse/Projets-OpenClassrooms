//
//  CoreDataManager.swift
//  Projet10
//
//  Created by Raphaël Goupille on 11/11/2021.
//

import Foundation
import CoreData

final class CoreDataManager {
    // MARK: - Properties
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favorites: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    // MARK: - Initializer
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    // MARK: - Methods
    func createFavorite(recipe: RecipeToDisplay) {
        let favorite = Favorite(context: managedObjectContext)
        favorite.label = recipe.recipeName
        favorite.image = recipe.recipeImageString
        favorite.ingredients = recipe.recipeIngredient
        favorite.uri = recipe.idString
        favorite.calories = recipe.recipeCalories
        favorite.url = recipe.instructionsUrl
        favorite.totalTime = Int64(recipe.cookingTime)
        coreDataStack.saveContext()
    }
    
    func deleteAllTasks() {
        favorites.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    
    func deleteFavorite(recipe: RecipeToDisplay) {
        
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipe.idString)
        
        guard let favoriteToDelete = try? managedObjectContext.fetch(request) else { print("didn't find favorite for delete")
            return }
        managedObjectContext.delete(favoriteToDelete[0])
    }
    
}



