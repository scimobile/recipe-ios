//
//  RealmRecipeDataSource.swift
//  Recipe
//
//  Created by user on 27/09/2024.
//

import Foundation
import RealmSwift

class RealmRecipeDataSource {
    private let realm = try! Realm()
    
    func fetchRecipe(complection: @escaping (Result<[RecipeObject], Error>) -> Void) {
        let recipes = realm.objects(RecipeObject.self)
        complection(.success(Array(recipes)))
    }
    
    func addRecipe(_ recipe: RecipeObject, complection: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write {
                realm.add(recipe, update: .modified)
            }
            complection(.success(()))
        } catch {
            complection(.failure(error))
        }
    }
    
    func deleteAllRecipe(complection: @escaping (Result<Void, Error>) -> Void) {
        do {
            let allRecipes = realm.objects(RecipeObject.self)
            try realm.write {
                realm.delete(allRecipes)
            }
            complection(.success(()))
        } catch {
            complection(.failure(error))
        }
    }
    
    func doneIngredientById(ingredientId: String, isDone: Bool) -> Void{
        do {
            try realm.write {
                if let ingredientObject = realm.object(ofType: IngredientObject.self, forPrimaryKey: ingredientId) {
                    ingredientObject.isDone = isDone
                }
            }
        } catch {
            print("Something went wrong!")
        }
    }
    
    func deleteRecipeById(byId recipeId: String, complection: @escaping (Result<Void, Error>) -> Void) {
        if let recipeToDelete = realm.object(ofType: RecipeObject.self, forPrimaryKey: recipeId) {
            try! realm.write {
                if recipeToDelete.isInvalidated {
                    print("DEBUG: Object is Invalidated")
                } else {
                    realm.delete(recipeToDelete)
                    print("DEBUG: Object delted successful")
                }
            }
            complection(.success(()))
        }
    }
}
