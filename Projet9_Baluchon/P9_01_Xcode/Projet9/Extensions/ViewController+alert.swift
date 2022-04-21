//
//  ViewController+alert.swift
//  Projet9
//
//  Created by Raphaël Goupille on 13/09/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
