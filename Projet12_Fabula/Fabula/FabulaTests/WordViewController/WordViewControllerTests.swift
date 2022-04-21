//
//  WordViewController.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 13/02/2022.
//

import XCTest
import Firebase
@testable import Fabula

class WordViewControllerTests: XCTestCase {

    
    func testViewControllerGetWords_WhenErrorOccured_ThenWordsCountEqualOne() {
        
        let session = FakeFireStoreSession(fakeResponse: FakeResponse(result: nil, error: NetworkError.errorOccured))
        
        let wordService = WordService(session: session)
        
        let wordViewModel = WordViewModel(wordService: wordService, words: [Word]())
        
        let wordViewController = WordViewController()
        
        wordViewController.wordViewModel = wordViewModel
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        wordViewController.wordViewModel?.getWords()
        
        XCTAssert(wordViewModel.words.count == 0)
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
 

}
