//
//  RecipeCardViewCell.swift
//  Recipe
//
//  Created by user on 22/08/2024.
//

import UIKit
import DropDown
import RealmSwift

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
    
    private var ingredient: Ingredient?
    
    // MARK: LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
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
    
    private func setupDropdown(_ recipe: RecipeObject) {
        dropDown.dataSource = options
        dropDown.anchorView = selectDropdownMenuButton
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectPeopleLabel.text = item
            updateIngredientQuantity(recipeId: recipe.id, newQuantity: item)
        }
    }
    
    func updateIngredientQuantity(recipeId: String, newQuantity: String) {
        let realm = try! Realm()
        let newQuantityNumber = Double(newQuantity) ?? 0.0
        if let recipe = realm.object(ofType: RecipeObject.self, forPrimaryKey: recipeId) {
            try! realm.write {
                for ingredient in recipe.ingredients {
                    let parts = ingredient.quantity.split(separator: " ")
                    print("\(parts[0]) and \(parts[1])")
                    let subString = parts.map { Double($0) ?? 0.0}
                    print("\(subString[0] * newQuantityNumber)")
                    let updatedQuantity = subString[0] * newQuantityNumber
                    
                    ingredient.quantity = "\(updatedQuantity) \(parts[1])"
                }
                NotificationCenter.default.post(name: NSNotification.Name("IngredientQuantityUpdated"), object: nil)
            }
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
    func config(with recipe: RecipeObject) {
        titleLabel.text = recipe.name
        cardImageView.image = UIImage(named: "SignupBg")
        
        setupDropdown(recipe)
    }
}
