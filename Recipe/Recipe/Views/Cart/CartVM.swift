//
//  CartViewModel.swift
//  Recipe
//
//  Created by user on 19/09/2024.
//

import UIKit

class CartVM {
    
    // MARK: -Properties
    var dummyRecipeData = Recipe.dummyRecipeData()
    var ingredientsByCategory: [(String, [(Recipe, Ingredient)])] = []
    var doneIngredients: [(Recipe, Ingredient, originalSection: Int, originalIndex: Int)] = []
    var onIngredientsChanged: (() -> Void)?
    
    init() {
        groupIngredientsByCategory()
    }
    
    private func groupIngredientsByCategory() {
        var tempDict = [String: [(Recipe, Ingredient)]]()
        
        for recipe in dummyRecipeData {
            for ingredient in recipe.ingredients {
                tempDict[ingredient.category, default: []].append((recipe, ingredient))
            }
        }
        
        ingredientsByCategory = tempDict.sorted(by: { $0.key < $1.key })
    }
    
    func handleCheckboxTap(at indexPath: IndexPath) {
        var selectedIngredient: (Recipe, Ingredient)
        
        if indexPath.section < ingredientsByCategory.count {
            selectedIngredient = ingredientsByCategory[indexPath.section].1.remove(at: indexPath.row)
            doneIngredients.append((selectedIngredient.0, selectedIngredient.1, indexPath.section, indexPath.row))
            
            if ingredientsByCategory[indexPath.section].1.isEmpty {
                ingredientsByCategory.remove(at: indexPath.section)
            }
        } else {
            let (recipe, ingredient, originalSection, originalIndex) = doneIngredients.remove(at: indexPath.row)
            
            if originalSection < ingredientsByCategory.count {
                ingredientsByCategory[originalSection].1.insert((recipe, ingredient), at: originalIndex)
            } else {
                ingredientsByCategory.append((ingredient.category, [(recipe, ingredient)]))
                ingredientsByCategory.sort(by: { $0.0 < $1.0 }) // Ensure sections remain sorted
            }
        }
        
        onIngredientsChanged?()
        
    }
    
    func numberOfSections() -> Int {
        return ingredientsByCategory.count + (doneIngredients.isEmpty ? 0 : 1)
    }
    
    func numberOfRows(in section: Int) -> Int {
        if section < ingredientsByCategory.count {
            return ingredientsByCategory[section].1.count
        } else {
            return doneIngredients.count
        }
    }
}
