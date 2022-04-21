//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    var calculation = Calculation()
    
    // MARK: - View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculation.delegate = self
        
        let longPressClearButton = UILongPressGestureRecognizer(target: self, action: #selector(longPressClearButton))
        view.addGestureRecognizer(longPressClearButton)
    }

    // MARK: - Methods
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calculation.tapNumber(number: numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let symbol = sender.title(for: .normal) else {
            return
        }
        
        calculation.tapOperator(symbol: symbol)
    }
    
    @objc func longPressClearButton() {
        calculation.tapLongPress()
    }
        
    @IBAction func tappedClearButton(_ sender: Any) {
        calculation.tapClear()
    }
    
    @IBAction func tappedDotButton(_ sender: Any) {
        calculation.tapDot()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculation.tapEqual()
}
}

// MARK: - Extension for CalculationDelegate
extension ViewController: CalculationDelegate {

    func stringToDisplay(string: String) {
        textView.text = string
    }
    
    func alertToDisplay(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
    
    
