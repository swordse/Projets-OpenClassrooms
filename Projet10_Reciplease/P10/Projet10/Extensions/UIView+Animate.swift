//
//  UIView+Animate.swift
//  Projet10
//
//  Created by Raphaël Goupille on 19/11/2021.
//

import Foundation
import UIKit

extension UIView {
    // extension to animate the search tableview
    func show() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: [], animations: {
            self.transform = .identity
        }, completion: nil)
    }
    
    func hide() {
        UIView.animate(withDuration: 0.8, delay: 0.5, options: [], animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y: +UIScreen.main.bounds.height)
            
        }, completion: nil)
    }
    
}
