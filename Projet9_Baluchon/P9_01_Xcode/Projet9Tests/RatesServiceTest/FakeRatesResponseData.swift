//
//  FakeRatesResponse.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 15/09/2021.
//

import Foundation

class FakeRatesResponseData {
    static let url: URL = URL(string: "http://data.fixer.io/api/latest?access_key=0bc21a7070fd37a8cc7f9ab931e45b34&symbols")!
    // fake response
    static let responseOK = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    // fake error
    class RatesError: Error {}

    static let error = RatesError()

    // fake data
    
    static var ratesCorrectData: Data {
        let bundle = Bundle(for: FakeRatesResponseData.self)
        let url = bundle.url(forResource: "Rates", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let ratesIncorrectData = "n'importe quoi".data(using: .utf8)!
    
}
