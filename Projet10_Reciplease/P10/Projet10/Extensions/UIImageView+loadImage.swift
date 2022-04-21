//
//  UIImageView+loadImage.swift
//  Projet10
//
//  Created by Raphaël Goupille on 15/11/2021.
//

import Foundation
import UIKit


extension UIImageView {
    // extension to load image and use if available the cache
    func load(recipeImageString: String, idString: String) {
        // check if image is already in cache, if so use it
        let cache = CacheImage.cache
        if let cachedImage =
            cache.object(forKey: NSString(string: idString)) {
            print("use cached image")
            self.image = cachedImage
        } else {
            // image is not in cache so load the image
            print("load image")
            guard let url = URL(string: recipeImageString) else {
                self.image = UIImage(named: "defaultRecipe")
                return }
            DispatchQueue.global().async {
                [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            // save the image in cache
                            cache.setObject(image, forKey: NSString(string: idString))
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.image = UIImage(named: "defaultRecipe")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: "defaultRecipe")
                    }
                }
            }
        }
    }
    
    // set the black gradient for the images bottom
    func setListImageGradient() {
        let initialColor = UIColor.black.withAlphaComponent(0.0)
        let finalColor = UIColor.black
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [initialColor.cgColor, initialColor.cgColor, finalColor.cgColor]
        gradientLayer.locations = [0, 0.4, 1]
        gradientLayer.frame = self.bounds
        
        self.layer.addSublayer(gradientLayer)
    }
    
    func setHeaderImageGradient() {
        let initialColor = UIColor.black.withAlphaComponent(0.0)
        let finalColor = UIColor.black.withAlphaComponent(0.5)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [initialColor.cgColor, initialColor.cgColor, finalColor.cgColor]
        gradientLayer.locations = [0, 0.7, 1]
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
}
