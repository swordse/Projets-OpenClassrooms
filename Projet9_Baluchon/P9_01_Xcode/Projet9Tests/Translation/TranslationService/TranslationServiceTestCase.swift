@testable import Projet9

import XCTest

class TranslationServiceTestCase: XCTestCase {

    // creation de la fausse session
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionsConfiguration = URLSessionConfiguration.ephemeral
        sessionsConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionsConfiguration
    }()
    
    
    func testFetch_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeTranslationData.url: (nil, FakeTranslationData.responseOK, FakeTranslationData.error)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: TranslationService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getTranslation(textToTranslate: "pyramide", source: "fr", target: "en", callback: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .noData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.2)
    }
    
    
    func testFetch_WhenFakeSessionWithResponseErrorIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeTranslationData.url: (nil, FakeTranslationData.responseKO, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: TranslationService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getTranslation(textToTranslate: "pyramide", source: "fr", target: "en", callback: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .invalidResponse)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetch_WhenFakeSessionWithIncorrectDataIsPassed_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeTranslationData.url: (FakeTranslationData.translationIncorrectData, FakeTranslationData.responseOK, nil)]
        // la session est créé avec les éléments paramétrés précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: TranslationService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getTranslation(textToTranslate: "pyramide", source: "fr", target: "en", callback: { result in
            guard case .failure(let error) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .undecodableData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testFetch_WhenFakeSessionWithCorrectData_ThenShouldReturnAnError() {
        // on modifie sessionConfiguration avec les données souhaitées
        URLProtocolFake.fakeURLS = [FakeTranslationData.url: (FakeTranslationData.translationCorrectData, FakeTranslationData.responseOK, nil)]
        // la session est créé avec les éléments précédemment
        let fakeSession = URLSession(configuration: sessionConfiguration)
        // injection de dépendance?
        let sut: TranslationService = .init(session: fakeSession)
        
        let expectation = XCTestExpectation(description: "Wait")
        
        sut.getTranslation(textToTranslate: "pyramide", source: "fr", target: "en", callback: { result in
            guard case .success(let result) = result else {
                XCTFail("Test Failed: \(#function)")
                return
            }
            XCTAssertTrue(result.data.translations[0].translatedText == "pyramid")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
    


