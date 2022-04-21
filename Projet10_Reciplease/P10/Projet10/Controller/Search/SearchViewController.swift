//
//  SearchTableViewController.swift
//  Projet10
//
//  Created by Raphaël Goupille on 05/11/2021.
//

import UIKit

final class SearchViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties
    private var screen = Screen()
    private var ingredients = [String]()
    private var recipeService = RecipeService()
    private var searchResult = [Detail]()
    private var alert = CustomAlert()
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var whiteBackgroundView: UIView!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextfield.setBorder()
        whiteBackgroundView.transform = CGAffineTransform.init(translationX: 0, y: +UIScreen.main.bounds.height)
        whiteBackgroundView.layer.cornerRadius = 40
        whiteBackgroundView.setShadow()
        
        addButton.layer.cornerRadius = 10
        
        searchButton.layer.cornerRadius = 10
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
    }
    
    // MARK: - Methods
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if searchTextfield.hasText {
            if ingredients.isEmpty {
                whiteBackgroundView.show()
            }
            
            guard let ingredientName = searchTextfield.text else { return }
            // obtain an array of words tapped
            let tappedIngredient = ingredientName.components(separatedBy: " ")
            // remove empty string
            let ingredientsAdded = tappedIngredient.filter { word in
                word != ""
            }
            
            ingredients += ingredientsAdded
            searchTextfield.text = ""
            ingredientTableView.reloadData()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        ingredients.removeAll()
        UIView.transition(with: ingredientTableView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.ingredientTableView.reloadData()
        }) { _ in
            self.whiteBackgroundView.hide()
        }
        searchResult.removeAll()
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        activityIndicator.isHidden = false
        searchButton.isEnabled = false
        
        let searchWords = ingredients.joined(separator: ",")
        
        recipeService.getRecipe(searchWords: searchWords, nextPage: nil) { result in
            
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                switch result {
                case.failure(.noData):
                    print("pas de donnée")
                    self.alert.showAlert(with: "Sorry", message: "No result for this search.", on: self)
                    break
                case.failure(.invalidResponse):
                    print("réponse non valide")
                    self.alert.showAlert(with: "Sorry", message: "An error occured.", on: self)
                    break
                case.failure(.undecodableData):
                    print("données indécodable")
                    self.alert.showAlert(with: "Sorry", message: "An error occured.", on: self)
                    break
                case.success(let result):
                    let recipes = result.recipes
                    print("Resultat de l'appel: \(recipes)")
                    
                    self.searchResult = recipes.map({ $0.recipe })
                    
                    let nextPage = result.links.next.href
                    
                    if recipes.count == 0 {
                        self.alert.showAlert(with: "Sorry!", message: "No result for this search.", on: self)
                        self.searchButton.isEnabled.toggle()
                        return
                    }
                    let recipeTableViewController = self.screen.createRecipeTableViewController() as! RecipeTableViewController
                    recipeTableViewController.searchResult = self.searchResult
                    recipeTableViewController.nextPage = nextPage
                    self.navigationController?.pushViewController(recipeTableViewController, animated: true)
                }
                
                self.searchButton.isEnabled.toggle()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - TableView DataSource, Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?
            .text = ingredient
        cell.imageView?.image = UIImage(systemName: "checkmark")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
}
