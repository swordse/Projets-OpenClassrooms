//
//  UIActivityIndicator+toggle.swift
//  Projet9
//
//  Created by Raphaël Goupille on 16/09/2021.
//

import Foundation
import UIKit


extension UIActivityIndicatorView {
    
    func isVisible(_ bool: Bool) {
        if bool {
            isHidden = false
            startAnimating()
        } else {
            isHidden = true
            stopAnimating()
        }
    }
    
    
}
