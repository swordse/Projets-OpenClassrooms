//
//  FakeWeatherResponseData.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 15/09/2021.
//

import Foundation


class FakeWeatherResponseData {
    
    static let url: URL = URL(string: "http://api.openweathermap.org/data/2.5/group?id=2968815,5128581&appid=60d8036cdbf22d8ec42ae3ae093d909d&units=metric")!
    
    static let urlSearch: URL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=paris&appid=60d8036cdbf22d8ec42ae3ae093d909d&units=metric")!
    
    // fake response
    static let responseOK = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    // fake error
    class WeatherError: Error {}

    static let error = WeatherError()

    // fake data
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static var correctDataSearch: Data {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "WeatherSearch", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let incorrectData = "n'importe quoi".data(using: .utf8)!
    
    
}
