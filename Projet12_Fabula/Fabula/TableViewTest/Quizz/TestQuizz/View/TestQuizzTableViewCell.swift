//
//  TestQuizzTableViewCell.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 04/01/2022.
//

import UIKit
// cell for the propositions
final class TestQuizzTableViewCell: UITableViewCell {
    
    static let identifier = "TestQuizzTableViewCell"
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }()
    
    let propositionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var selectedIndex: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(propositionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .deepBlue
        contentView.addSubview(backView)
        backView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 10)
        backView.layer.cornerRadius = 15
        backView.addSubview(propositionLabel)
        propositionLabel.layer.cornerRadius = 15
        propositionLabel.frame = CGRect(x: 5, y: 5, width: backView.frame.size.width - 10, height: backView.frame.size.height - 10)
        propositionLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    func setCell(proposition: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.propositionLabel.text = proposition
        }
    }
}
