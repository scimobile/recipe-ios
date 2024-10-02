//
//  RecipeRepository.swift
//  Recipe
//
//  Created by user on 27/09/2024.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func getRecipe(completion: @escaping (Result<[RecipeObject], Error>) -> Void)
    func addRecipe(_ recipe: RecipeObject, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAllRecipe(complection: @escaping (Result<Void, Error>) -> Void)
}

class RecipeRepository: RecipeRepositoryProtocol {
    private let realmDataSource: RealmRecipeDataSource
    
    init(realmDataSource: RealmRecipeDataSource) {
        self.realmDataSource = realmDataSource
    }
    
    func getRecipe(completion: @escaping (Result<[RecipeObject], Error>) -> Void) {
        realmDataSource.fetchRecipe(complection: completion)
    }
    
    func addRecipe(_ recipe: RecipeObject, completion: @escaping (Result<Void, Error>) -> Void) {
        realmDataSource.addRecipe(recipe, complection: completion)
    }
    
    func deleteAllRecipe(complection: @escaping (Result<Void, Error>) -> Void) {
        realmDataSource.deleteAllRecipe(complection: complection)
    }
    
    func doneIngredientById(ingredientId: String, isDone: Bool) {
        realmDataSource.doneIngredientById(ingredientId: ingredientId, isDone: isDone)
    }
}
