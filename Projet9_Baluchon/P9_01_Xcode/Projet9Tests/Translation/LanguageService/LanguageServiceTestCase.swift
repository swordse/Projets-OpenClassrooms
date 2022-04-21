@testable import Projet9

import XCTest

class LanguageServiceTestCase: XCTestCase {

    // creation de la fausse session
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionsConfiguration = URLSessionConfiguration.ephemeral
        sessionsConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionsConfiguration
    }()
    
    
    func testFetch_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeLanguageData.url: (nil, FakeLanguageData.responseOK, FakeLanguageData.error)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance
        let sut: LanguagesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchLanguages { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testFetch_WhenFakeSessionWithResponseErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeLanguageData.url: (nil, FakeLanguageData.responseKO, nil)]
        // la session est créée avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: LanguagesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchLanguages { result in
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
        URLProtocolFake.fakeURLS = [FakeLanguageData.url: (FakeLanguageData.languageIncorrectData, FakeLanguageData.responseOK, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: LanguagesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchLanguages { result in
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
        URLProtocolFake.fakeURLS = [FakeLanguageData.url: (FakeLanguageData.languageCorrectData, FakeLanguageData.responseOK, nil)]
        // la session est créé avec les éléments précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: LanguagesService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.fetchLanguages { result in
            guard case .success(let success) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(success.data.languages[0].name == "Afrikaans")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
    


