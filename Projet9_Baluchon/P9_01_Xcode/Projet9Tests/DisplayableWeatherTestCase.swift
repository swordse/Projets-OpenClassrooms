//
//  DisplayableWeatherTestCase.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 21/09/2021.
//
@testable import Projet9
import XCTest

class DisplayableWeatherTestCase: XCTestCase {

    let displayableWeather = DisplayableWeather()
    let cityIdCodable = CityIdCodable(list: [List(weather: [Weather(id: 2, main: "main", description: "description")], main: Temperature(temp: 13, temp_min: 8, temp_max: 16), name: "Rome"), List(weather: [Weather(id: 4, main: "main", description: "description")], main: Temperature(temp: 3, temp_min: 1, temp_max: 5), name: "Paris")])
    
    let searchCityCodable = SearchCityCodable(weather: [Weather(id: 3, main: "main", description: "description")], main: Temperature(temp: 12, temp_min: 10, temp_max: 14), name: "Chicago")
    
    override func setUpWithError() throws {
        _ = DisplayableWeather()
        
    }

    func testGivenCityCodeWhenCreateCitiesThenCities() {
        let cities = DisplayableWeather.createCities(result: cityIdCodable)
        
        XCTAssertTrue(cities[0].cityName == "Rome")
    }
    
    func testGivenSearchCityCodeWhenCreateCityThenCity() {
        let city = DisplayableWeather.createCity(result: searchCityCodable)
        
        XCTAssertTrue(city.cityName == "Chicago")
    }
    
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
