//
//  CommentTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 09/01/2022.
//

import UIKit
// cell for the comments
class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else {
                return
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            
            authorNameLabel.text = comment.userName
            commentText.text = comment.commentText
            dateLabel.text = formatter.string(from: comment.date)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
    }

}
