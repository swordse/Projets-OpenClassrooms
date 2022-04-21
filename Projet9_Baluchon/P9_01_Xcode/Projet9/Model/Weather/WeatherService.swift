//
//  WeatherService.swift
//  Projet9
//
//  Created by Raphaël Goupille on 20/08/2021.
//

import Foundation

// fetch the weather information
class WeatherService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // fetch the weather when user tap search
    func fetchWeatherSearch(city: String, callback: @escaping(Result<SearchCityCodable, NetworkError>)-> Void) {
        var url: String {  "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.weatherKey)&units=metric"}
        guard let url = URL(string: url) else { return }
        session.dataTask(with: url, callback: callback)
    }
    
    // fetch the weather for the two initials cities: Paris and New York
    func fetchWeatherId(callback: @escaping(Result<CityIdCodable, NetworkError>)-> Void) {
        let url = "http://api.openweathermap.org/data/2.5/group?id=2968815,5128581&appid=60d8036cdbf22d8ec42ae3ae093d909d&units=metric"
        guard let url = URL(string: url) else { return }
        session.dataTask(with: url, callback: callback)
    }
    
}
