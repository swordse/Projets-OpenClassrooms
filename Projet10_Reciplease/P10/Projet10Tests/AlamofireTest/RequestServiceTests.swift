//
//  Projet10Tests.swift
//  Projet10Tests
//
//  Created by Raphaël Goupille on 09/11/2021.
//

import XCTest
import Alamofire
@testable import Projet10


    class RequestServiceTests: XCTestCase {

        func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = FakeEdamamSession(fakeResponse: FakeResponse(response: nil, data: nil))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getRecipe(searchWords: "tea", nextPage: nil, callBack: { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with no data failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
                                     wait(for: [expectation], timeout: 0.01)
            }

        func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
            let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getRecipe(searchWords: "tea", nextPage: nil, callBack: { result in
                guard case .failure(let error) = result else {
                        XCTFail("Test getData method with incorrect response failed.")
                        return
                    }
                    XCTAssertNotNil(error)
                    expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }

        func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getRecipe(searchWords: "tea", nextPage: nil, callBack: { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with undecodable data failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }

        func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
            let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getRecipe(searchWords: "tea", nextPage: nil, callBack: { result in
                guard case .success(let data) = result else {
                    XCTFail("Test getData method with correct data failed.")
                    return
                }
                
                XCTAssertTrue(data.count == 10000)
                expectation.fulfill()
            }) 
            wait(for: [expectation], timeout: 0.01)
        }
    
        func testGetData_WhenCorrectNextPageIsPassed_ThenShouldReturnSuccededCallback() {
            let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
            let requestService = RecipeService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getRecipe(searchWords: nil, nextPage: "https://api.edamam.com/api/recipes/v2?q=milk%2Cchocolate&app_key=d273d3a64c27559b6e74e67f60501b38&_cont=CHcVQBtNNQphDmgVQntAEX4BYlZ3GgoOQ2FHAWQWZVd2Fh8VRGVDB2ASMVJzUQIEF2BBBDMaZFV0AABUR2AWB2IWa1JhaR8VFScfXnAZYVVvFkBWFTAzUj5MIQwmR2FWHTIVEWhYLhg%3D&type=public&app_id=93b8bd9f", callBack: { result in
                guard case .success(let data) = result else {
                    XCTFail("Test getData method with correct data failed.")
                    return }
                
                XCTAssertTrue(data.count == 10000)
                expectation.fulfill()
            })
            wait(for: [expectation], timeout: 0.01)
        }
    

    }
