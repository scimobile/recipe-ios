//
//  PersonalizeRecipesCell.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

class PersonalizeRecipesCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                containerView.borderStyle(width: isSelected ? 1 : 0, borderColor: isSelected ? .activeOrange : .clear)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.dropShadow()
        titleLabel.font = .popM11
    }

    func bind(data: DummyRecipes) {
        iconImage.image = data.icon
        titleLabel.text = data.title
    }
}
