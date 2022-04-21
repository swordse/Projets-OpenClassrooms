//
//  CurrenciesTableViewController.swift
//  Projet9
//
//  Created by Raphaël Goupille on 24/08/2021.
//

import UIKit

protocol InfoDelegate {
    func passData(currencyToConvert: [String: String])
}

final class CurrenciesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var delegate: InfoDelegate?
    let service = CurrenciesService()
    var currenciesList: (CurrencyCodable)?
    var currencies = [Dictionary<String, String>.Element]()
    private var currencyToConvert = [String: String]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filterCurrencies : [Dictionary<String, String>.Element] = []
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var customAlert = CustomAlert()
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Liste des devises"
        navigationController?.setNavigationBarHidden(false, animated: true)
        // set up searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search currency"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        // retrieve currenciesList from userDefaults, if not, fetch data
        retrieveOrSaveData()
        
    }
    
    // MARK: - Methods
    
    func retrieveOrSaveData() {
        CurrenciesListUserDefaults.retrieve { result in
            switch result {
            case .success(let currenciesList):
                reloadTableView(with: currenciesList)
            case .failure(let error):
                print(error)
                fetchData()
            }
        }
    }
    // fetch the currencies list
    private func fetchData() {
        service.fetchCurrencies { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.customAlert.showAlert(with: "Oups !", message: "Un problème est survenu. Veuillez vérifier votre connexion.", on: self)
                    print(error)
                case .success(let result):
                    CurrenciesListUserDefaults.save(dataToSave: result)
                    self.currenciesList = result
                    self.reloadTableView(with: self.currenciesList)
                }
            }
        }
    }
    
    private func reloadTableView(with currencies: CurrencyCodable?) {
        guard let currenciesToOrder = currencies else {
            print("no currenciesList for reload table view")
            return
        }
        
        self.currencies = currenciesToOrder.symbols.sorted(by: {$0.key < $1.key} )
        self.tableView.reloadData()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filterCurrencies = currencies.filter({ currency in
            currency.value.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filterCurrencies.count
        } else {
            return currencies.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let currency: Dictionary<String, String>.Element
        if isFiltering {
            currency = filterCurrencies[indexPath.row]
        } else {
            currency = currencies[indexPath.row]
        }
        
        cell.textLabel?.text = currency.key
        cell.detailTextLabel?.text = currency.value
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !filterCurrencies.isEmpty {
            let key = filterCurrencies[indexPath.row].key
            let value = filterCurrencies[indexPath.row].value
            currencyToConvert = [key: value]
            
        } else {
            let key = currencies[indexPath.row].key
            let value = currencies[indexPath.row].value
            currencyToConvert = [key: value]
        }
        delegate?.passData(currencyToConvert: currencyToConvert)
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension CurrenciesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
}
