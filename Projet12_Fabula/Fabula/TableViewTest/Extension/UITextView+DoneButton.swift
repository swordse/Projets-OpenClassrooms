//
//  UITextView+DoneButton.swift
//  Fabula
//
//  Created by Raphaël Goupille on 25/02/2022.
//

import Foundation
import UIKit

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
            
            let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                                  y: 0.0,
                                                  width: UIScreen.main.bounds.size.width,
                                                  height: 44.0))//1
            let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
            toolBar.setItems([flexible, barButton], animated: false)
            self.inputAccessoryView = toolBar
        }
}
