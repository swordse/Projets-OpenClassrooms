//
//  Screen.swift
//  Projet10
//
//  Created by Raphaël Goupille on 23/11/2021.
//

import UIKit

struct Screen {
    
    private let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    func createSearchViewController() -> UIViewController {
        return mainStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    }
    
    func createRecipeTableViewController() -> UITableViewController {
        return mainStoryBoard.instantiateViewController(withIdentifier: "RecipeTableViewController") as! RecipeTableViewController
    }
    
    func createDetailRecipeTableViewController() -> UITableViewController {
        return mainStoryBoard.instantiateViewController(withIdentifier: "DetailRecipeTableViewController") as! DetailRecipeTableViewController
    }
    
}
