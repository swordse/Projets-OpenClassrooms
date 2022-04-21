//
//  CategoryQuizzCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 29/12/2021.
//

import UIKit

final class CategoryQuizzCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = "categoryCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryQuizzCollectionViewCell", bundle: nil)
    }
    
    func setCell(category: QuizzCategoryInfo) {
        backView.layer.cornerRadius = 15
        backView.backgroundColor = category.color
        categoryLabel.text = category.name
        categoryLabel.textColor = .white
        categoryLabel.font = categoryLabel.font.withSize(18)
        categoryImage.image = category.image
        
        categoryLabel.textColor = .white
    }
    
    func borderIsSet(_ isTrue: Bool) {
        backView.layer.borderColor = (UIColor.label).cgColor
        isTrue ? (backView.layer.borderWidth = 2) : (backView.layer.borderWidth = 0)
    }
    // animation of the category image when selected
    func tiltImage() {
        categoryImage.tilt()
    }
}
