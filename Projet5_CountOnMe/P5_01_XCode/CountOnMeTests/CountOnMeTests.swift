
import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    var calculation: Calculation!
    var mockDelegate: MockDelegate!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        calculation = Calculation()
        mockDelegate = MockDelegate()
        calculation.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        calculation = nil
        try super.tearDownWithError()
    }
// MARK: - Test tapNumber
    // test basic number tapped when 0 is displayed
    func testGivenNoNumberTappedWhenTapNumberThenNumberIsDisplay() {
        calculation.calculationString = "0"
        calculation.tapNumber(number: "1")
        
        XCTAssertEqual(mockDelegate.displayString, "1")
    }
    
    // test basic number tapped when number is displayed
    func testGivenNumberDisplayedWhenTapNumberThenNumberIsDisplay() {
        calculation.calculationString = "1"
        calculation.tapNumber(number: "1")
        
        XCTAssertEqual(mockDelegate.displayString, "11")
    }
    
    // test when Calculation contains "Error"
    func testGivenCalculationIsErrorWhenTapNumberThenCalculationIsNumber() {
        calculation.calculationString = "Erreur"
        calculation.tapNumber(number: "8")
        
        XCTAssertEqual(mockDelegate.displayString, "8")
    }
    
// MARK: - Test tapClear
    // tap clear when is empty
    func testGivenCalculationIsEmptyWhenTapClearThenReturn() {
        calculation.calculationString = ""
        calculation.tapClear()
        
        XCTAssertTrue(mockDelegate.displayAlert == "")
    }
    // test clear when has result
    func testGivenCalculationHasResultWhenTapClearThenCalculationIs0() {
        calculation.calculationString = "8 + 2 = 10"
        calculation.tapClear()
        XCTAssertTrue(mockDelegate.displayString == "0")
    }
    
    // when calculation has operator, tap clear delete the 3 last characters " x "
    func testGivenCalculationLastIsOperatorWhenTapClearThen3LastCharactersAreDeleted () {
        calculation.calculationString = "8 + "
        calculation.tapClear()
        
        XCTAssertEqual(mockDelegate.displayString, "8")
    }
    
    // when last calculation is number, tap clear delete last
    func testGivenCalculationLastIsNumberWhenTapClearThenLastCharacterIsDeleted () {
        calculation.calculationString = "88"
        calculation.tapClear()
        
        XCTAssertEqual(mockDelegate.displayString, "8")
    }
   
    // tap several times clear
    func testGivenCalculationLastIsNumberWhenTapClearSeveralTimesThen0IsDisplayed () {
        calculation.calculationString = "88"
        calculation.tapClear()
        calculation.tapClear()
        
        XCTAssertEqual(mockDelegate.displayString, "0")
    }
    
    // tap clear when Erreur is displayed
    func testGivenErreurIsDisplayedWhenTapClearThen0IsDisplayed() {
        calculation.calculationString = "Erreur"
        calculation.tapClear()
        
        XCTAssertTrue(calculation.calculationString == "0")
    }
    
    // MARK: - Test tapLongPress
    func testGivenCalculationWhenLongPressClearButtonThenCalculationEqual0() {
        calculation.calculationString = "8 + 1000"
        calculation.tapLongPress()
        
        XCTAssertEqual(mockDelegate.displayString, "0")
    }
    
    // MARK: - Test tapDot
    
    // test dot is added if last is integer
    func testGivenLastIsIntegerWhenTapDotThenDotIsAdded() {
        calculation.calculationString = "88"
        calculation.tapDot()
        
        XCTAssertEqual(mockDelegate.displayString, "88.")
    }
    
    // test dot can't be added to empty
    func testGivenIsEmptyWhenTapDotThenNewDotIsNotDisplay() {
        calculation.calculationString = ""
        calculation.tapDot()
        
        XCTAssertEqual(mockDelegate.displayString, "")
    }
    
    // test dot can't be added to a decimal number
    func testGivenDecimalNumberWhenTapDotThenNewDotIsNotDisplay() {
        calculation.calculationString = "8."
        calculation.tapDot()
        
        XCTAssertEqual(mockDelegate.displayString, "8.")
    }
    
    // test dot can't be added to an Erreur
    func testGivenErreurIsDisplayWhenTapDotThenNewDotIsNotDisplay() {
        calculation.calculationString = "Erreur"
        calculation.tapDot()
        
        XCTAssertEqual(mockDelegate.displayString, "Erreur")
    }
    
    // test dot can't be added to a result
    func testGivenResultIsDisplayWhenTapDotThenNewDotIsNotDisplay() {
        calculation.calculationString = "8 + 2 = 10"
        calculation.tapDot()
        
        XCTAssertTrue(mockDelegate.displayString == "8 + 2 = 10")
    }
    
    // MARK: - Test tapOperator
    
    // when calculation display result, if operator is tapped it is applied to the result
    func testGivenResultIsDisplayWhenTapOperatorThenOperatorIsAppliedToResult() {
        calculation.calculationString = "1 + 2 = 3"
        calculation.tapOperator(symbol: "+")
        
        XCTAssertEqual(mockDelegate.displayString, "3 + ")
    }
    // when calculation is correct tap operator append operator
    func testGivenCalculationIsCorrectWhenTapOperatorThenOperatorIsAppended() {
        calculation.calculationString = "1 + 2"
        calculation.tapOperator(symbol: "+")
        
        XCTAssertEqual(mockDelegate.displayString, "1 + 2 + ")
    }
    // when calculation is incorrect tap operator shows alert
    func testGivenCalculationIsNotCorrectWhenTapOperatorThenAlertIsShown() {
        calculation.calculationString = "1 + "
        calculation.tapOperator(symbol: "+")
        
        XCTAssertEqual(mockDelegate.displayAlert, "title: Zero, message: Entrez une expression correcte")
    }
    
    // MARK: - Test tapEqual
    
    // test basic operation
    func testGivenCalculationIsCorrectWhenTapEqualThenResultDisplay() {
        calculation.calculationString = "1 + 2 - 1 x 6 / 2"
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayString, "1 + 2 - 1 x 6 / 2 = 0")
    }
    
    // test when there is already a result, display 0
    func testGivenCalculationHasResultWhenTapEqualThen0Display() {
        calculation.calculationString = "1 + 2 + 5 = 8"
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayString, "0")
    }
    
    // when calculation finished with an operator, when equal is tapped an alert is shown
    func testGivenCalculationFinishWithOperatorWhenTapEqualThenAlertIsShown() {
        calculation.calculationString = "8 + "
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayAlert, "title: Zero, message: Entrez une expression correcte.")
    }
    // when calculation count is less than 3, if equal is tapped an alert is shown
    func testGivenCalculationHas1NumberWhenTapEqualThenAlertIsShown () {
        calculation.calculationString = "8"
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayAlert, "title: Zero, message: Complétez votre calcul.")
    }
    
    // test alert when divided by 0
    func testGivenCalculationIsNumberWhenDividedBy0ThenAlertIsShownAndErrorIsDisplay() {
        calculation.calculationString = "7 / 0"
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayAlert, "title: Attention, message: Il n'est pas possible de diviser par 0")
        XCTAssertEqual(mockDelegate.displayString, "Erreur")
    }
    
    // when tap unknown operator
    func testGivenCalculationHasUnknownOperatorWhenTapEqualThenAlertIsDisplayed() {
        calculation.calculationString = "2 * 3"
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayAlert, "title: Erreur, message: Un opérateur inconnu a été utilisé")
    }
    
    // test when number is huge decimal result has 2 decimals
    func testGivenCalculationHasBigDecimalWhenTapEqualThenDecimal2Displayed() {
        calculation.calculationString = "1 + 2.99999999"
        calculation.tapEqual()
        
        XCTAssertEqual(mockDelegate.displayString, "1 + 2.99999999 = 4")
    }
    
    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

