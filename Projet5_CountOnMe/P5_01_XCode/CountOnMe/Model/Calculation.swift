
import Foundation

protocol CalculationDelegate {
    func stringToDisplay(string: String)
    
    func alertToDisplay(title: String, message: String)
}

class Calculation {
    
    // MARK: - Properties
    
    var delegate: CalculationDelegate!
    // computed property that calls the delegate
    var calculationString = " " {
        didSet {
            delegate.stringToDisplay(string: calculationString)
        }
    }
    // computed property to split the calculation string into an array of elements
    private var elements: [String] {
        return calculationString.split(separator: " ").map { "\($0)" }
    }
    
    private var isCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "Erreur"
    }
    
    private var hasEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var hasResult: Bool {
        return calculationString.firstIndex(of: "=") != nil
    }
    
    // MARK: - Methods
    func tapNumber(number: String) {
        guard hasResult || calculationString == "Erreur" || calculationString == "0" else { return calculationString.append(number) }
        calculationString = number
    }
    
    func tapClear() {
        // if textView is empty return
        guard !calculationString.isEmpty else {
            return
        }
        // if textView contains "=", textView is 0
        guard !hasResult else {
            return calculationString = "0"
        }
        //if textView last character is empty remove 3 last characters
        guard !(calculationString.last == " " && calculationString.count >= 3) else {
            return calculationString.removeLast(3)
        }
        
        guard !elements.contains("Erreur") else {
            return calculationString = "0"
        }
        
        calculationString.removeLast()
        if calculationString.count == 0 {
            calculationString = "0"
        }
    }
    
    func tapLongPress() {
        calculationString = "0"
    }
    
    func tapDot() {
        guard let lastElement = elements.last else {
            return
        }
        
        if lastElement.contains(".") || lastElement.contains("Erreur") {
            return
        }
        
        if hasResult {
            return
        }
        
        if calculationString.last == " " {
            calculationString.append("0.")
        } else {
        calculationString.append(".")
        }
    }
    
    func tapOperator(symbol: String) {
        if hasResult {
            if let result = elements.last {
                calculationString = "\(result) \(symbol) "
                return
            }
        }
        if isCorrect {
            calculationString.append(" \(symbol) ")
        } else {
            delegate.alertToDisplay(title: "Zero", message: "Entrez une expression correcte")
        }
    }
    
    func tapEqual() {
        guard !hasResult else {
            return calculationString = "0"
        }
        guard isCorrect else {
            return delegate.alertToDisplay(title: "Zero", message: "Entrez une expression correcte.")
        }
        guard hasEnoughElement else {
            return delegate.alertToDisplay(title: "Zero", message: "Complétez votre calcul.")
        }
        if result() != nil {
            calculationString.append(result()!)
        }
    }
    
    private func result() -> String? {
        // Create local copy of operations
        var operationsToReduce = elements
        var result = Double()
        // find the correct index using calculation priority
        var index: Int {
            let index = operationsToReduce.firstIndex { element in
                element.contains("x") || element.contains("/")
            }
            guard let resultIndex = index else {
                return 1
            }
            return resultIndex
        }
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            if let left = Double(operationsToReduce[index - 1]), let right = Double(operationsToReduce[index + 1]) {
                let operand = operationsToReduce[index]
                if operand == "/" && right == 0 {
                    delegate.alertToDisplay(title: "Attention", message: "Il n'est pas possible de diviser par 0")
                    calculationString = "Erreur"
                    return nil
                } else {
                    switch operand {
                    case "+": result = left + right
                    case "-": result = left - right
                    case "x": result = left * right
                    case "/": result = left / right
                    default: delegate.alertToDisplay(title: "Erreur", message: "Un opérateur inconnu a été utilisé")
                    //                        fatalError("Unknown operator !")
                    }
                    operationsToReduce[index - 1] =  String(result)
                    operationsToReduce.remove(at: index + 1)
                    operationsToReduce.remove(at: index)
                }
            }
        }
        let roundedResult = stringFormatter(double: result)
        return (" = \(roundedResult)")
    }
    
    private func stringFormatter(double: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        
        let number = NSNumber(value: double)
        guard let rounded = formatter.string(from: number) else { return "Erreur" }
        return rounded
        
    }
}
