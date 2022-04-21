@testable import Projet9

import XCTest

class CurrenciesServiceTestCase: XCTestCase {

    // creation de la fausse session
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionsConfiguration = URLSessionConfiguration.ephemeral
        sessionsConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionsConfiguration
    }()
    
    
    func testFetch_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeCurrenciesResponseData.url: (nil, FakeCurrenciesResponseData.responseOK, FakeCurrenciesResponseData.error)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: CurrenciesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchCurrencies { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetch_WhenFakeSessionWithResponseErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeCurrenciesResponseData.url: (nil, FakeCurrenciesResponseData.responseKO, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: CurrenciesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchCurrencies { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetch_WhenFakeSessionWithIncorrectDataIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeCurrenciesResponseData.url: (FakeCurrenciesResponseData.currenciesIncorrectData, FakeCurrenciesResponseData.responseOK, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: CurrenciesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchCurrencies { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetch_WhenFakeSessionWithCorrectData_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeCurrenciesResponseData.url: (FakeCurrenciesResponseData.currenciesCorrectData, FakeCurrenciesResponseData.responseOK, nil)]
        // la session est créé avec les éléments précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: CurrenciesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchCurrencies { result in
            guard case .success(let success) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(success.symbols["BTC"] == "Bitcoin")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
    


