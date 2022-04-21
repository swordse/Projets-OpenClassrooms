//
//  ThemeQuizzCollectionViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 29/12/2021.
//

import UIKit

// list of the theme of each category
final class ThemeQuizzCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var themeLabel: UILabel!

    static let identifier = "themeCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ThemeQuizzCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
    }
    
    func setCell(theme: String) {
        themeLabel.text = theme
    }
}
