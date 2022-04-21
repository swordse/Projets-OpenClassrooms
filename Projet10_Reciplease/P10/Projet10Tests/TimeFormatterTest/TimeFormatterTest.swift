//
//  TImeFormatterTest.swift
//  Projet10Tests
//
//  Created by Raphaël Goupille on 20/11/2021.
//

import XCTest

@testable import Projet10

class TimeFormatterTest: XCTestCase {
    
    override func setUpWithError() throws {
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGiven0_WhenFormat_ThenShouldReturnTilde() {
        let string = TimeFormatter.minutesToHours(minutes: 0)
        XCTAssertTrue(string == " ~ ")
    }
    
    func testGiven10_WhenFormat_ThenShouldReturnMinutes() {
        let string = TimeFormatter.minutesToHours(minutes: 10)
        XCTAssertTrue(string == "10mn")
    }
    
    func testGiven60_WhenFormat_ThenShouldReturnHour() {
        let string = TimeFormatter.minutesToHours(minutes: 60)
        XCTAssertTrue(string == "1h")
    }
    
    func testGiven70_WhenFormat_ThenShouldReturnHoursAndMinutes() {
        let string = TimeFormatter.minutesToHours(minutes: 70)
        XCTAssertTrue(string == "1h 10mn")
    }
    
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
