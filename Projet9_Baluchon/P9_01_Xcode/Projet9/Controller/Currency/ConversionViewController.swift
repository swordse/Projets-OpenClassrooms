//
//  TestViewController.swift
//  Projet9
//
//  Created by Raphaël Goupille on 04/09/2021.
//

import UIKit

final class ConversionViewController: UIViewController {
    
    // MARK: - Properties
    
    private var rateService = RatesService()
    private var ratesList: (RatesCodable)?
    private var convert = Convert()
    private var currencyToConvert = ["Eur": "Euro"]
    private var customAlert = CustomAlert()
    
    // calculated property to get the USD rate from the ratesList
    private var USDRate: Double {
        guard let USD = ratesList?.rates["USD"] else { return 0}
        print(USD)
        return USD
    }
    
    // calculated property to get the rate of the selected currency
    private var currencyRate: Double {
        guard let chosenCurrency = currencyToConvert.first else { return 0}
        print("chosenCurrency \(chosenCurrency)")
        if chosenCurrency.key == "Eur" {
            return 1
        } else {
            guard let rate = ratesList?.rates["\(chosenCurrency.key)"] else {
                return 0
            }
            return rate
        }
    }
    
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var amountToConvertTextfield: UITextField!
    
    @IBOutlet weak var currencyView: UIView!
    
    @IBOutlet weak var dollarTextfield: UITextField!
    
    @IBOutlet weak var convertedTextfield: UITextField!
    
    @IBOutlet weak var rateAppliedLabel: UILabel!
    
    // MARK: - View life cycles
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Set view
        currencyButton.setBorder()
        currencyButton.setImageAndTitle()
        amountToConvertTextfield.setBorder()
        currencyView.setBorder()
        currencyView.setShadow()
        dollarTextfield.setBorder()
        dollarTextfield.setShadow()
        // tapGesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        
        view.addGestureRecognizer(tapGesture)
        // swipeGesture to convert
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(convertCurrency))
        swipeGesture.direction = .down
        
        view.addGestureRecognizer(swipeGesture)
        
        if ratesList == nil {
            // get the rates (different from the request to get the currency's name)
            rateService.getRates { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.customAlert.showAlert(with: "Oups !", message: "Une erreur s'est produite. Veuillez recommencer ultérieurement.", on: self)
                        print(error)
                    case .success(let success):
                        self.ratesList = success
                    }
                }
            }
        } else {
            return
        }
        
        amountToConvertTextfield.addDoneButton(title: "Done", target: self, selector: #selector(doneTapped))
        
        rateAppliedLabel.text = "Taux de change appliqué: "
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        currencyButton.setTitle("\(currencyToConvert.first!.key): \(currencyToConvert.first!.value)", for: .normal)

    }
    
    
    @IBAction func currencyButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCurrencies", sender: self)
    }
    
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
    
    @objc func convertCurrency() {
        // view is animated down and up
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: 30)
        } completion: { _ in
            self.view.transform = CGAffineTransform.identity
        }
        
        // we get the amount to convert
        guard let amount = Double(amountToConvertTextfield.text!) else {
            customAlert.showAlert(with: "Oups !", message: "Vous devez mentionner un montant correct.", on: self)
            return
        }
        
        let result = convert.calculation(amount: amount, currencyRate: currencyRate, USDRate: USDRate)
        
        convertedTextfield.text = "\(result)$"
        
        rateAppliedLabel.text = "Taux de change appliqué: \(Formatter.numberToString(number: USDRate/currencyRate)) "
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrencies" {
            let vcDestination = segue.destination as? CurrenciesTableViewController
            vcDestination?.delegate = self
        }
    }
    
}

extension ConversionViewController : InfoDelegate {
    func passData(currencyToConvert: [String: String]) {
        self.currencyToConvert = currencyToConvert
    }
}

