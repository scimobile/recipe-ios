//
//  RecipeEntity.swift
//  Recipe
//
//  Created by user on 20/09/2024.
//

import Foundation
import RealmSwift

class IngredientObject: Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var quantity: String
    @Persisted var category: String
    @Persisted var isDone: Bool
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class RecipeObject: Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var imageURL: String
    @Persisted var servings: Int
    @Persisted var ingredients = List<IngredientObject>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

