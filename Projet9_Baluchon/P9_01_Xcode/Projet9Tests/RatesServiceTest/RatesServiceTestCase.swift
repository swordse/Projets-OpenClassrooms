//
//  RatesServiceTestCase.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 15/09/2021.
//

@testable import Projet9

import XCTest

class RatesServiceTestCase: XCTestCase {

    // creation de la fausse session
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionsConfiguration = URLSessionConfiguration.ephemeral
        sessionsConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionsConfiguration
    }()
    
    
    func testFetchRates_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeRatesResponseData.url: (nil, FakeRatesResponseData.responseOK, FakeRatesResponseData.error)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: RatesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getRates { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testFetchRates_WhenFakeSessionWithResponseErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeRatesResponseData.url: (nil, FakeRatesResponseData.responseKO, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: RatesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getRates { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetchRates_WhenFakeSessionWithIncorrectDataIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeRatesResponseData.url: (FakeRatesResponseData.ratesIncorrectData, FakeRatesResponseData.responseOK, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: RatesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getRates { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetchRates_WhenFakeSessionWithCorrectData_ThenShouldReturnASuccess() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeRatesResponseData.url: (FakeRatesResponseData.ratesCorrectData, FakeRatesResponseData.responseOK, nil)]
        // la session est créé avec les éléments précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: RatesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getRates { result in
            guard case .success(let success) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(success.date == "2021-09-15")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
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


