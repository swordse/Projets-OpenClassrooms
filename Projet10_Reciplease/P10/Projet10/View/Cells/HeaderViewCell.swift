//
//  HeaderViewCell.swift
//  Projet10
//
//  Created by Raphaël Goupille on 12/11/2021.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "HeaderViewCell"
    
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    @IBOutlet weak var likeBackgroundView: UIView!
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var recipe: RecipeToDisplay? {
        didSet {
            
            guard let recipe = recipe else {
                return
            }
            headerLabel.text = recipe.recipeName
            ingredientLabel.text = "Ingredients:"
            calorieLabel.text = "\(Int(recipe.recipeCalories)) cal"
            timeLabel.text = TimeFormatter.minutesToHours(minutes: recipe.cookingTime)
            headerImage.load(recipeImageString: recipe.recipeImageString, idString: recipe.idString)
        }
    }
    // MARK: - Life cycle
    static func nib() -> UINib {
        return UINib(nibName: "HeaderViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerImage.clipsToBounds = true
        headerImage.contentMode = .scaleAspectFill
        likeBackgroundView.setBorder()
        likeBackgroundView.layer.cornerRadius = 10
        headerImage.setHeaderImageGradient()
    }
    
    // MARK: - Method
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
