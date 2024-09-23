//
//  CartViewModel.swift
//  Recipe
//
//  Created by user on 19/09/2024.
//

import UIKit
import RealmSwift

class CartVM {
    
    // MARK: -Properties
    var dummyRecipeData = Recipe.dummyRecipeData()
    private var realm: Realm = try! Realm()
    private(set) var ingredientsByCategory: [(String, [(Recipe, Ingredient)])] = []
    private(set) var doneIngredients: [(Recipe, Ingredient, originalSection: Int, originalIndex: Int)] = []
    var onIngredientsChanged: (() -> Void)?
    var onNoData: (() -> Void)?
    
    init() {
        
//        deleteAllData()

        loadRecipeDataFromRealm()
//        groupIngredientsByCategory()
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

    
    private func defaultRecipeData() {
        let dummyRecipeData = Recipe.dummyRecipeData()
        addRecipeToRealm(dummyRecipeData)
    }
    
    func loadRecipeDataFromRealm() {
        
        let recipes = realm.objects(RecipeObject.self)

        if recipes.isEmpty {
            // onNoData?()
            defaultRecipeData()
            return
        }

        var tempDict = [String: [(Recipe, Ingredient)]]()
        doneIngredients.removeAll()

        for recipeObject in recipes {
            let recipe = Recipe(id: recipeObject.id,
                                name: recipeObject.name,
                                imageURL: recipeObject.imageURL,
                                servings: recipeObject.servings,
                                ingredients: [])

            for ingredientObject in recipeObject.ingredients {
                let ingredient = Ingredient(id: ingredientObject.id,
                                            name: ingredientObject.name,
                                            IngreimageUrl: "",
                                            quantityPerServing: "",
                                            quantity: ingredientObject.quantity,
                                            category: ingredientObject.category,
                                            checked: ""
                )

                if ingredientObject.isDone {
                    doneIngredients.append((recipe, ingredient, 0, 0))
                } else {
                    tempDict[ingredient.category, default: []].append((recipe, ingredient))
                }
            }
        }
        ingredientsByCategory = tempDict.sorted(by: { $0.key < $1.key })
        onIngredientsChanged?()
    }
    
    func deleteAllData() {
        try! self.realm.write {
            realm.deleteAll()
        }
        
        loadRecipeDataFromRealm()
    }
    
    func addRecipeToRealm(_ recipes: [Recipe]) {
        try! realm.write {
            for recipe in recipes {
                let recipeObject = RecipeObject()
                recipeObject.id = recipe.id
                recipeObject.name = recipe.name
                recipeObject.imageURL = recipe.imageURL
                recipeObject.servings = recipe.servings

                for ingredient in recipe.ingredients {
                    let ingredientObject = IngredientObject()
                    ingredientObject.id = ingredient.id
                    ingredientObject.name = ingredient.name
                    ingredientObject.quantity = ingredient.quantity
                    ingredientObject.category = ingredient.category
                    ingredientObject.isDone = false
                    recipeObject.ingredients.append(ingredientObject)
                }
                realm.add(recipeObject, update: .modified)
            }
        }

        loadRecipeDataFromRealm()
    }
    
    
    func handleCheckboxTap(at indexPath: IndexPath) {
        
        if indexPath.section < ingredientsByCategory.count {
            let (recipe, ingredient) = ingredientsByCategory[indexPath.section].1.remove(at: indexPath.row)
            
            try! realm.write {
                if let ingredientObject = self.realm.object(ofType: IngredientObject.self, forPrimaryKey: ingredient.id) {
                    ingredientObject.isDone = true
                }
            }
            
            doneIngredients.append((recipe, ingredient, indexPath.section, indexPath.row))
            
            if ingredientsByCategory[indexPath.section].1.isEmpty {
                ingredientsByCategory.remove(at: indexPath.section)
            }
        } else {
            let (recipe, ingredient, originalSection, originalIndex) = doneIngredients.remove(at: indexPath.row)
            
            try! realm.write {
                if let ingredientObject = self.realm.object(ofType: IngredientObject.self, forPrimaryKey: ingredient.id) {
                    ingredientObject.isDone = false
                }
            }
            
            if originalSection < ingredientsByCategory.count {
                ingredientsByCategory[originalSection].1.insert((recipe, ingredient), at: originalIndex)
            } else {
                ingredientsByCategory.append((ingredient.category, [(recipe, ingredient)]))
                ingredientsByCategory.sort(by: { $0.0 < $1.0 })
            }
        }
//        onIngredientsChanged?()
        loadRecipeDataFromRealm()
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
