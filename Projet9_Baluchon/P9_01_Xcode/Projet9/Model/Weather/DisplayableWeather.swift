//
//  Weather.swift
//  Projet9
//
//  Created by Raphaël Goupille on 22/08/2021.
//

import Foundation

// struct to process the weather data in useable object for the UI
struct DisplayableWeather {
    var id: Int = 0
    var description: String = ""
    var preciseDescription: String = ""
    var actualTemp: Double = 0
    var maxTemp: Double = 0
    var minTemp: Double = 0
    var cityName: String = ""
    
    static func createCities(result: CityIdCodable) -> [DisplayableWeather] {
         var cities = [DisplayableWeather]()
         
         for i in 0 ..< result.list.count {
             let element = result.list[i]
             let displayWeather = DisplayableWeather(id: element.weather[0].id,
                                                     description: element.weather[0].main,
                                                     preciseDescription: element.weather[0].description,
                                                     actualTemp: element.main.temp,
                                                     maxTemp: element.main.temp_max,
                                                     minTemp: element.main.temp_min,
                                                     cityName: element.name)
             cities.append(displayWeather)
             
         }
         return cities
     }
    
    static func createCity(result: SearchCityCodable) -> DisplayableWeather {
        
        let displayWeather = DisplayableWeather(id: result.weather[0].id,
                                                description: result.weather[0].main,
                                                preciseDescription: result.weather[0].description,
                                                actualTemp: result.main.temp,
                                                maxTemp: result.main.temp_max,
                                                minTemp: result.main.temp_min,
                                                cityName: result.name)
        
        return displayWeather
    }
}
