//
//  FakeResponseData.swift
//  Projet10Tests
//
//  Created by Raphaël Goupille on 17/11/2021.
//

import Foundation
@testable import Projet10

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Edamam", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var incorrectData = "erreur".data(using: .utf8)!
    
    
}
