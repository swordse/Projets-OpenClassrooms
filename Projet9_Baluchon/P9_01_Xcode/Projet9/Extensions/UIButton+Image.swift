//
//  UIButton+Image.swift
//  Projet9
//
//  Created by Raphaël Goupille on 09/09/2021.
//

import Foundation
import UIKit

extension UIButton {
    // title on the left, image on the right
    func setImageAndTitle() {
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
    
}
