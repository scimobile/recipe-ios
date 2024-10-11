//
//  RecipeCardViewCell.swift
//  Recipe
//
//  Created by user on 22/08/2024.
//

import UIKit
import DropDown
import RealmSwift
import SDWebImage

protocol RecipeCardViewCellDelegate: AnyObject {
    func didTapDeleteRecipe(with recipeId: String)
    func didUpdateIngredientQuantity(forRecipeId recipeId: String, newQuantity: String)
}

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
    private let dropDownWidth = 80.0

    private var vm: CartVM = CartVM.shared
    private var recipe: RecipeObject?
    private weak var delegate: RecipeCardViewCellDelegate?
    
    // MARK: LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        cardImageView.layer.cornerRadius = 10
        selectDropdownMenuButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(deleteRecipe), for: .touchUpInside)
        contentView.dropShadow()
    }
    
    private func setupDropdown(_ recipe: RecipeObject) {
        dropDown.dataSource = options
        dropDown.anchorView = selectDropdownMenuButton
        dropDown.width = dropDownWidth
        dropDown.cornerRadius = 10
        dropDown.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectPeopleLabel.text = item
            delegate?.didUpdateIngredientQuantity(forRecipeId: recipe.id, newQuantity: item)
        }
    }
    
    // MARK: - Selector
    @objc private func toggleDropdown() {
        dropDown.show()
    }
    
    @objc private func deleteRecipe() {
        guard let recipeId = recipe?.id else { return }
        print("DEBUG: Deleting recipe with id \(recipeId)")
        delegate?.didTapDeleteRecipe(with: recipeId)
    }
    
    // MARK: - Configuration
    func config(with recipe: RecipeObject, delegate: RecipeCardViewCellDelegate?) {
        titleLabel.text = recipe.name
        if let imageUrl = URL(string: recipe.imageURL) {
            cardImageView.sd_setImage(with: imageUrl)
        } else {
            cardImageView.image = UIImage(named: "SignupBg")
        }
        setupDropdown(recipe)
        self.recipe = recipe
        self.delegate = delegate
    }
}
