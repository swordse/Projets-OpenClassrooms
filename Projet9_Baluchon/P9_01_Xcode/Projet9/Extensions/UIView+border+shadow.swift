//
//  UIView+border.swift
//  Projet9
//
//  Created by Raphaël Goupille on 09/09/2021.
//

import Foundation
import UIKit


extension UIView {
    
    func setBorder() {
        layer.cornerRadius = 7
        layer.borderWidth = 0.5
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 4
    }
    
}

