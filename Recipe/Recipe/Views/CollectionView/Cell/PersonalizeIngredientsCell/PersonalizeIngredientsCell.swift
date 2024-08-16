//
//  PersonalizeIngredientsCell.swift
//  Recipe
//
//  Created by kukuzan on 14/08/2024.
//

import UIKit

class PersonalizeIngredientsCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 20
        titleLabel.font = .popM14
    }
    
    func render(flag: Bool,title: String) {
        titleLabel.text = title
        containerView.borderStyle(width: flag ? 0 : 1, borderColor: flag ? .clear : .secondary)
        flag == true ?
        (containerView.backgroundColor = .activeOrange) :
        (containerView.backgroundColor = .white)
        flag == true ?
        (titleLabel.textColor = .white) :
        (titleLabel.textColor = .secondary)
    }
    
}
