//
//  ListViewCell.swift
//  Projet10
//
//  Created by Raphaël Goupille on 12/11/2021.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "ListCell"
    
    private let cache = NSCache<NSString, UIImage>()
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    @IBOutlet weak var likeView: UIView!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var recipe: RecipeToDisplay? {
        didSet {
            guard let recipe = recipe else {
                return
            }
            nameLabel.text = recipe.recipeName
            ingredientLabel.text = recipe.recipeIngredient
            likeLabel.text = "\(Int(recipe.recipeCalories)) cal"
            recipeImage.load(recipeImageString: recipe.recipeImageString, idString: recipe.idString)
            timeLabel.text = TimeFormatter.minutesToHours(minutes: recipe.cookingTime)
        }
    }
    // MARK: - Life cycle
    static func nib() -> UINib {
        return UINib(nibName: "ListViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.clipsToBounds = true
        recipeImage.contentMode = .scaleAspectFill
        likeView.setBorder()
        likeView.layer.cornerRadius = 10
        recipeImage.setListImageGradient()
    }
    
    // MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
