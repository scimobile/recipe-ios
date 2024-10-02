//
//  CartVM.swift
//  Recipe
//
//  Created by user on 19/09/2024.
//

import UIKit
import RealmSwift

class CartVM {
    
    // MARK: -Properties
    var dummyRecipeData = Recipe.dummyRecipeData()
    private let recipeRepository: RecipeRepository
    var realm: Realm = try! Realm()
    private(set) var ingredientsByCategory: [(String, [(Recipe, Ingredient)])] = []
    private(set) var doneIngredients: [(Recipe, Ingredient, originalSection: Int, originalIndex: Int)] = []
    var onIngredientsChanged: (() -> Void)?
    var onNoData: (() -> Void)?
    var recipeObj: [RecipeObject] = [RecipeObject]()
    
    init() {
        recipeRepository = RecipeRepository(realmDataSource: RealmRecipeDataSource())
        
//        deleteAllData()
        defaultRecipeData()
        
        recipeRepository.getRecipe(completion: {  [unowned self] result in
            switch result {
                case .success(let recipes):
                    self.recipeObj = recipes
                    self.loadRecipeDataFromRealm()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    //MARK: Testing Method
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
    
    func createRecipe(from recipeObject: RecipeObject) -> Recipe {
        return Recipe(id: recipeObject.id,
                      name: recipeObject.name,
                      imageURL: recipeObject.imageURL,
                      servings: recipeObject.servings,
                      ingredients: [])
    }
    
    func createIngredient(from ingredientObject: IngredientObject) -> Ingredient {
        return Ingredient(id: ingredientObject.id,
                          name: ingredientObject.name,
                          IngreimageUrl: "",
                          quantityPerServing: "",
                          quantity: ingredientObject.quantity,
                          category: ingredientObject.category,
                          checked: "")
    }
    
    func loadRecipeDataFromRealm() {
        let recipes = recipeObj
        
        if recipes.isEmpty {
            onNoData?()
            return
        }
        
        var tempDict = [String: [(Recipe, Ingredient)]]()
        doneIngredients.removeAll()
        
        for recipeObject in recipes {
            let recipe = createRecipe(from: recipeObject)
            
            for ingredientObject in recipeObject.ingredients.sorted(byKeyPath: "category", ascending: true) {
                let ingredient = createIngredient(from: ingredientObject)

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
        recipeRepository.deleteAllRecipe(complection: { result in
            switch result {
                case .success():
                    print("Delete All from realm")
                case .failure(_):
                    print("Error: deleteAllData")
            }
        })
        loadRecipeDataFromRealm()
    }
    
    func addRecipeToRealm(_ recipes: [Recipe]) {
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
            recipeRepository.addRecipe(recipeObject, completion: { result in
                switch result {
                    case .success():
                        print("add Recipe data to realmDB")
                    case .failure(_):
                        print("Error: Recipe data to realmDB")
                }
            })
        }
    }
    
    func handleCheckboxTap(at indexPath: IndexPath) {
        if indexPath.section < ingredientsByCategory.count {
            let (recipe, ingredient) = ingredientsByCategory[indexPath.section].1.remove(at: indexPath.row)
            recipeRepository.doneIngredientById(ingredientId: ingredient.id, isDone: true)
            doneIngredients.append((recipe, ingredient, indexPath.section, indexPath.row))
            if ingredientsByCategory[indexPath.section].1.isEmpty {
                ingredientsByCategory.remove(at: indexPath.section)
            }
        } else {
            let (recipe, ingredient, originalSection, originalIndex) = doneIngredients.remove(at: indexPath.row)
            recipeRepository.doneIngredientById(ingredientId: ingredient.id, isDone: false)
            ingredientsByCategory.append((ingredient.category, [(recipe, ingredient)]))
            ingredientsByCategory.sort(by: { $0.0 < $1.0 })
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
extension CartVM: IngredientCellDelegate {
    func didUpdateQuantity(_ recipeObj: RecipeObject) {
        try! realm.write {
            print(recipeObj.ingredients.count)
            onIngredientsChanged?()
        }
    }
}

