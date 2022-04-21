//
//  RecipeTableViewController.swift
//  Projet10
//
//  Created by Raphaël Goupille on 31/10/2021.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    // MARK: - Properties
    private let screen = Screen()
    private var recipesToDisplay = [RecipeToDisplay]()
    var searchResult = [RecipeToDisplay]()
    var nextPage: String?
    let recipeService = RecipeService()
    private var isSearch = true
    private var coreDataManager: CoreDataManager?
    private var detailToDisplay: RecipeToDisplay?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ListViewCell.nib(), forCellReuseIdentifier: ListViewCell.identifier)
        title = "Search Result"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "BlueColor")!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //         get the index of the tabbar item
        var index = 0
        if TabBarController.indexOfTab != nil {
            index = TabBarController.indexOfTab!
        }
        // index of the search item
        if index == 0 {
            recipesToDisplay = searchResult
            isSearch = true
            title = "Search Result"
        }
        // index of the favorite item
        if index == 1 {
            fetchCoreData()
            isSearch = false
            title = "Favorite"
        }
        tableView.reloadData()
        //        print("TabBarController index :\(tabBarController?.selectedIndex)")
    }
    // MARK: - Method
    private func fetchCoreData() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        let recipes = coreDataManager?.favorites
        guard let recipes = recipes else { return }
        recipesToDisplay = recipes
    }
    
    // MARK: - Table view data source & delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as! ListViewCell
        let recipe = recipesToDisplay[indexPath.row]
        cell.recipe = recipe
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailToDisplay = recipesToDisplay[indexPath.row]
        let detailRecipeTableViewController = screen.createDetailRecipeTableViewController() as! DetailRecipeTableViewController
        detailRecipeTableViewController.recipe = detailToDisplay
        detailRecipeTableViewController.isSearch = isSearch
        navigationController?.pushViewController(detailRecipeTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = """
You haven't favorite yet. To had a favorite:
- do a research on the search page;
- select a recipe in the search result;
- click on the star in the right top corner.
"""
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isSearch {
            return 0
        } else {
            return coreDataManager?.favorites.isEmpty ?? true ? 200 : 0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isSearch {
            if indexPath.row + 1 == recipesToDisplay.count {
                recipeService.getRecipe(searchWords: nil, nextPage: nextPage) { result in
                    switch result {
                    case.failure(.noData):
                        print("pas de donnée")
                        CustomAlert().showAlert(with: "Sorry", message: "No result for this search.", on: self)
                        break
                    case.failure(.invalidResponse):
                        print("réponse non valide")
                        CustomAlert().showAlert(with: "Sorry", message: "An error occured.", on: self)
                    case.failure(.undecodableData):
                        print("données indécodable")
                        CustomAlert().showAlert(with: "Sorry", message: "An error occured.", on: self)
                    case.success(let result):
                        let recipes = result.recipes
                        let recipesToAppend = recipes.map { $0.recipe
                        }
                        self.recipesToDisplay.append(contentsOf: recipesToAppend)
                        self.nextPage = result.links.next.href
                        tableView.reloadData()
                    }
                }
            }
        } else {
            return
        }
    }
    
}
