//
//  CurrenciesListTestCase.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 20/09/2021.
//

@testable import Projet9

import XCTest

class CurrenciesListTestCase: XCTestCase {

    let currency = CurrencyCodable(symbols: ["Euros" : "Eur"])
    
    override func setUpWithError() throws {
        
        
    }

    func testGivenCurrenciesAreNotSavedWhenRetrieveOrSaveThenCurrencyIsSaved() {
        let controller = CurrenciesTableViewController()
        controller.currenciesList = nil
        CurrenciesListUserDefaults.save(dataToSave: currency)
        
        XCTAssertTrue(UserDefaults.standard.object(forKey: "currenciesList") != nil)
    }
    
    func testGivenCurrencyIsSavedWhenRetrieveThenDataIsDisplayed() {
        let controller = CurrenciesTableViewController()
        CurrenciesListUserDefaults.save(dataToSave: currency)
        controller.retrieveOrSaveData()
        XCTAssertTrue(controller.currencies[0].key == "Euros")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        UserDefaults.standard.removeObject(forKey: "currenciesList")
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
