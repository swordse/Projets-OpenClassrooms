//
//  UIView+TextFieldButton.swift
//  Projet9
//
//  Created by Raphaël Goupille on 13/09/2021.
//

import Foundation
import UIKit

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        if isEditable == true {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: target, action: selector)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
        else {
            return
        }
}
}

extension UITextField {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: target, action: selector)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
