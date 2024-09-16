//
//  CategoryTableViewCell.swift
//  Recipe
//
//  Created by user on 24/08/2024.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "CategoryTableViewCell"

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var checkboxButton: UIButton!
    
    // MARK: Events
    var checkboxTapped: (() -> Void)?
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
        checkboxTapped?()
    }
    
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // MARK: Configure
    func configure(with recipe: Recipe, ingredient: Ingredient, isDone: Bool) {
        servingLabel.text = ingredient.quantity
        ingredientName.text = ingredient.name
        recipeName.text = recipe.name
        
        let imageName = isDone ? "checkmark.circle.fill" : "checkmark.circle"
        checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func setInactiveStyle() {
        self.backgroundColor = UIColor.lightGray
        recipeName.textColor = UIColor.darkGray
        servingLabel.textColor = UIColor.darkGray
        ingredientName.textColor = UIColor.darkGray
    }
    
    func setActiveStyle() {
        self.backgroundColor = UIColor.white
        recipeName.textColor = UIColor.black
        servingLabel.textColor = UIColor.black
        ingredientName.textColor = UIColor.black
    }
}
