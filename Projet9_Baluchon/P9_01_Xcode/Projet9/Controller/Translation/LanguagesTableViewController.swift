//
//  LanguageTableViewController.swift
//  Projet9
//
//  Created by Raphaël Goupille on 30/08/2021.
//

import UIKit

// MARK: - Protocols

protocol PassSourceLanguage {
    func passLanguageSource(source: String, sourceName: String)
}

protocol PassTargetLanguage {
    func passLanguageTarget(target: String, targetName: String)
}

final class LanguagesTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    
    private let service = LanguagesService()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filterLanguages = [DataLanguagesCodable.Language]()
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return !isSearchBarEmpty && searchController.isActive
    }
    
    private var customAlert = CustomAlert()
    
    var isSourceLanguage = true
    
    private var languages = [DataLanguagesCodable.Language]()
    
    var sourceDelegate: PassSourceLanguage?
    var targetDelegate: PassTargetLanguage?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Liste de langues"
        navigationController?.setNavigationBarHidden(false, animated: false)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search language"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        LanguagesListUserDefaults.retrieve { result in
            switch result {
            case.success(let languageList):
                self.languages = languageList.data.languages
                tableView.reloadData()
            case .failure(let error):
                print(error)
                self.fetchData()
            }
        }
    }
    
    // MARK: - Methods
    
    private func fetchData() {
        service.fetchLanguages { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.customAlert.showAlert(with: "Oups !", message: "Un problème est survenu. Veuillez vérifier votre connexion.", on: self)
                    print(error)
                case.success(let result):
                    self.languages = result.data.languages
                    print(self.languages)
                    LanguagesListUserDefaults.save(languagesList: result)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func filterContentForSearchText(_ searchText: String ) {
        filterLanguages = languages.filter({ language in
            language.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterLanguages.count
        } else {
            return languages.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var language = DataLanguagesCodable.Language(language: "", name: "")
        if isFiltering {
            language = filterLanguages[indexPath.row]
        } else {
            language = languages[indexPath.row]
        }
        cell.textLabel?.text = language.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var choice = DataLanguagesCodable.Language(language: "", name: "")
        
        if !filterLanguages.isEmpty {
            choice = filterLanguages[indexPath.row]
        } else {
            choice = languages[indexPath.row]
        }
        
        if isSourceLanguage {
            sourceDelegate?.passLanguageSource(source: choice.language, sourceName: choice.name)
        } else {
            targetDelegate?.passLanguageTarget(target: choice.language, targetName: choice.name)
        }
    }
    
}

extension LanguagesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}
