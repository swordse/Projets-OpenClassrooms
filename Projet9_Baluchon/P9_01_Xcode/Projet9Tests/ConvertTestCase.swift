//
//  ConvertTestCase.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 15/09/2021.
//
@testable import Projet9
import XCTest

class ConvertTestCase: XCTestCase {

    
    func testGivenAmountIs1CurencyRate2USDRate1() {
        
        let convert = Convert()
        
        let result = convert.calculation(amount: 1, currencyRate: 2, USDRate: 2)
        
        XCTAssertTrue(result == "1")
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

}
