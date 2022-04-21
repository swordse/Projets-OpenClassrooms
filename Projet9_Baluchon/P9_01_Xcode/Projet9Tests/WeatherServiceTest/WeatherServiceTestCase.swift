//
//  WeatherServiceTestCase.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 15/09/2021.
//
@testable import Projet9
import XCTest

class WeatherServiceTestCase: XCTestCase {

    
    // creation de la fausse session
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionsConfiguration = URLSessionConfiguration.ephemeral
        sessionsConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionsConfiguration
    }()
    
    
    func testFetchRates_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.url: (nil, FakeWeatherResponseData.responseOK, FakeWeatherResponseData.error)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherId { result in
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
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.url: (nil, FakeWeatherResponseData.responseKO, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherId { result in
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
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.url: (FakeWeatherResponseData.incorrectData, FakeWeatherResponseData.responseOK, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherId { result in
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
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.url: (FakeWeatherResponseData.correctData, FakeWeatherResponseData.responseOK, nil)]
        // la session est créé avec les éléments précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherId { result in
            guard case .success(let success) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(success.list[0].name == "Paris")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}

class WeatherSearchServiceTestCase: XCTestCase {

    
    // creation de la fausse session
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionsConfiguration = URLSessionConfiguration.ephemeral
        sessionsConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionsConfiguration
    }()
    
    
    func testFetchRates_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.urlSearch: (nil, FakeWeatherResponseData.responseOK, FakeWeatherResponseData.error)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        sut.fetchWeatherSearch(city: "paris") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.2)
    }
    
    
    func testFetchRates_WhenFakeSessionWithResponseErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.urlSearch: (nil, FakeWeatherResponseData.responseKO, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherSearch(city: "paris") { result in
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
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.urlSearch: (FakeWeatherResponseData.incorrectData, FakeWeatherResponseData.responseOK, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherSearch(city: "paris") { result in
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
        URLProtocolFake.fakeURLS = [FakeWeatherResponseData.urlSearch: (FakeWeatherResponseData.correctDataSearch, FakeWeatherResponseData.responseOK, nil)]
        // la session est créé avec les éléments précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: WeatherService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchWeatherSearch(city: "paris") { result in
            guard case .success(let success) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(success.name == "Paris")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}

