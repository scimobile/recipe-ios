//
//  RecipeCardViewCell.swift
//  Recipe
//
//  Created by user on 22/08/2024.
//

import UIKit
import DropDown

class RecipeCardViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier = "RecipeCardViewCell"
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectPeopleLabel: UILabel!
    @IBOutlet weak var selectDropdownMenuButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    private let options = ["1", "2", "3", "4", "5", "6", "8", "10", "12", "14"]
    private var dropDown = DropDown()
    
    // MARK: LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupDropdown()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadow()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        cardImageView.layer.cornerRadius = 10
        selectDropdownMenuButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }
    
    private func setupDropdown() {
        dropDown.dataSource = options
        dropDown.anchorView = selectDropdownMenuButton
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectPeopleLabel.text = item
        }
    }
    
    private func configureShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }
    
    // MARK: - Selector
    @objc private func toggleDropdown() {
        dropDown.show()
    }
    
    // MARK: - Configuration
    func config(with recipe: Recipe) {
        titleLabel.text = recipe.name
        cardImageView.image = UIImage(named: "SignupBg")
    }
}
