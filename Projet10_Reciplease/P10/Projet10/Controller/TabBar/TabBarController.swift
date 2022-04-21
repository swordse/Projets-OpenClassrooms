//
//  TabBarController.swift
//  Projet10
//
//  Created by Raphaël Goupille on 12/11/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    static var indexOfTab: Int?
    
    private let screen = Screen()
    
    // MARK: - Cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchNavigationController = UINavigationController(rootViewController: screen.createSearchViewController())
        let searchTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        searchNavigationController.tabBarItem = searchTabBarItem
        
        let recipeNavigationController = UINavigationController(rootViewController: screen.createRecipeTableViewController())
        let recipeTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), selectedImage: nil)
        recipeNavigationController.tabBarItem = recipeTabBarItem
        
        viewControllers = [searchNavigationController, recipeNavigationController]
        tabBar.tintColor = UIColor(named: "GreenColor")
        tabBar.backgroundColor = .systemGray6
        tabBar.isTranslucent = true
        
    }
    
    // MARK: - Method
    // get the item tapped by user
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        TabBarController.indexOfTab = tabBar.items?.firstIndex(of: item)
    }
    
}
