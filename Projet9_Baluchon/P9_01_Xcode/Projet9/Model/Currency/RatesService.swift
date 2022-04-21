//
//  RatesService.swift
//  Projet9
//
//  Created by Raphaël Goupille on 18/08/2021.
//

import Foundation

// get the rates of the currencies
class RatesService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func getRates(callBack: @escaping(Result<RatesCodable, NetworkError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(Constants.firstCurrencyKey)&symbols") else { return }
        session.dataTask(with: url, callback: callBack)
    }
}


