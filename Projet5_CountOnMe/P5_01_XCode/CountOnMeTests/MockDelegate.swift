import Foundation
@testable import CountOnMe

class MockDelegate: CalculationDelegate {
    
    var displayString = ""
    var displayAlert = ""
    
    func stringToDisplay(string: String) {
        displayString = string
    }
    
    func alertToDisplay(title: String, message: String) {
        displayAlert = "title: \(title), message: \(message)"
    }

}
