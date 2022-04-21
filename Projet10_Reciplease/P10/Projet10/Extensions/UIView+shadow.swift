//
//  UIView+shadow.swift
//  Projet10
//
//  Created by Raphaël Goupille on 06/11/2021.
//

import Foundation
import UIKit

extension UIView {
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 10, height: 0)
        layer.shadowRadius = 4
    }
    
    func setBorder() {
        layer.borderWidth = 0.5
        layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
}
