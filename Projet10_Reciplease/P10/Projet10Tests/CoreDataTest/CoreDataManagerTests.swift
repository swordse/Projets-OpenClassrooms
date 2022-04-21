//
//  CoreDataManagerTests.swift
//  Projet10Tests
//
//  Created by Raphaël Goupille on 17/11/2021.
//

import Foundation
import CoreData
@testable import Projet10
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    func testAddFavoriteMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        let recipe = Detail(uri: "defefe", url: "vfvfbfbf", label: "label", image: "ggtrgr", ingredientLines: ["frcr", "dedede"], totalTime: 23, calories: 44)
        coreDataManager.createFavorite(recipe: recipe)
        
        XCTAssertTrue(coreDataManager.favorites.count == 1)
        XCTAssertTrue(coreDataManager.favorites[0].label == "label")
    }
    
    func testDeleteAllFavoriteMethods_WhenAnEntityIsCreatedandDeleted_ThenAllShouldBeCorrectlyDeleted() {
        let recipe = Detail(uri: "defefe", url: "vzbbzebe", label: "label", image: "ggtrgr", ingredientLines: ["frcr", "dedede"], totalTime: 23, calories: 44)
    coreDataManager.createFavorite(recipe: recipe)
    coreDataManager.deleteAllTasks()
        XCTAssertTrue(coreDataManager.favorites.isEmpty)
    }
    
    func testDeleteOneFavoriteMethods_WhenAnEntityIsCreatedandDeleted_ThenOneFavoriteShouldBeCorrectlyDeleted() {
        let recipe = Detail(uri: "defefe", url: "zbbeztbetbe", label: "label", image: "ggtrgr", ingredientLines: ["frcr", "dedede"], totalTime: 23, calories: 44)
//    let recipeTwo = Detail(uri: "defefe", label: "recipeTwo", image: "ggtrgr", ingredientLines: ["frcr", "dedede"], totalTime: 23, calories: 44)
    coreDataManager.createFavorite(recipe: recipe)
//    coreDataManager.createFavorite(recipe: recipeTwo)
    coreDataManager.deleteFavorite(recipe: recipe)
        XCTAssertTrue(coreDataManager.favorites.count == 0)
//        XCTAssertTrue(coreDataManager.favorites[0].label == "recipeTwo")
    }
}
