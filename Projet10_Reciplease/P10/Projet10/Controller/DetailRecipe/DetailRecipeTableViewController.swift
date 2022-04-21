//
//  DetailRecipeTableViewController.swift
//  Projet10
//
//  Created by Raphaël Goupille on 08/11/2021.
//

import UIKit

class DetailRecipeTableViewController: UITableViewController {
    // MARK: - Properties
    var recipe: RecipeToDisplay!
    var isSearch = true
    private var coreDataManager: CoreDataManager?
    
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HeaderViewCell.nib(), forCellReuseIdentifier: HeaderViewCell.identifier)
        getDirectionsButton.titleLabel?.font = .boldSystemFont(ofSize: 40)
        if isSearch {
            title = "Search Detail"
        } else {
            title = "Favorite Detail"
        }
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favButtonTapped))
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFavorite(recipe: recipe) {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        }
        tableView.reloadData()
    }
    
    // MARK: - Methods
    private func isFavorite(recipe: RecipeToDisplay) -> Bool {
        guard let favorites = coreDataManager?.favorites else { return false }
        for favorite in favorites {
            if favorite.uri == recipe.idString {
                return true
            }
        }
        return false
    }
    // check if we are working with favorite or search result
    @objc func favButtonTapped() {
        if isSearch {
            searchRecipeToFavorite()
        }
        // when tap on favButton in Favorite -> delete the favorite
        else {
            deleteFavorite()
        }
    }
    
    private func searchRecipeToFavorite() {
        // check if recipe is already a favorite, based on the image display. If it's "star", it's not a favorite so we can save.
        if navigationItem.rightBarButtonItem?.image == UIImage(systemName: "star") {
            guard let recipe = recipe else {
                return
            }
            coreDataManager?.createFavorite(recipe: recipe)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        }
        // it's already a favorite so we delete
        else {
            coreDataManager?.deleteFavorite(recipe: recipe)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        }
    }
    
    private func deleteFavorite() {
        let favorite: Favorite = recipe as! Favorite
        coreDataManager?.deleteFavorite(recipe: favorite)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDirectionsTapped(_ sender: Any) {
        if let url = URL(string: recipe.instructionsUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: HeaderViewCell.identifier) as! HeaderViewCell
        header.recipe = recipe
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.recipeIngredient.components(separatedBy: ", ").count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailRecipeCell", for: indexPath)
        let ingredients = recipe.recipeIngredient.components(separatedBy: ", ")
        let text = ingredients[indexPath.row]
        cell.textLabel?.text = "- \(text)"
        return cell
    }
    
}
