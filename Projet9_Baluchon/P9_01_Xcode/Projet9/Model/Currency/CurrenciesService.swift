//
//  CurrenciesService.swift
//  Projet9
//
//  Created by Raphaël Goupille on 24/08/2021.
//

import Foundation

// struct to get the list of currencies available
final class CurrenciesService {
    
    private let session: URLSession
    
    let baseStringURL: String = "http://data.fixer.io/api/symbols?access_key=\(Constants.firstCurrencyKey)"
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchCurrencies(callback: @escaping (Result<CurrencyCodable, NetworkError>) -> Void) {
        guard let url: URL = .init(string: baseStringURL) else { return }
        
        session.dataTask(with: url, callback: callback)
        
    }
}
