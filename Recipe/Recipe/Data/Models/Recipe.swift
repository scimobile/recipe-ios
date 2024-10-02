//
//  Recipe.swift
//  Recipe
//
//  Created by user(PaingLoop) on 18/08/2024.
//

import UIKit

// MARK: - Results
struct Results: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    let id, name: String
    let imageURL: String
    let servings: Int
    var ingredients: [Ingredient]

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
        case servings, ingredients
    }
    
    static func dummyRecipeData() -> [Recipe] {
        return [
            Recipe(id: "recipe1",
                   name: "Cajun Spiced Cauliflower Rice",
                   imageURL: "https://example.com/cauliflower_rice.jpg",
                   servings: 4,
                   ingredients: [
                        Ingredient(id: "ing1",
                                   name: "Ground Bee",
                                   IngreimageUrl: "",
                                   quantityPerServing: "",
                                   quantity: "1 lb",
                                   category: "Meat & Seafood", checked: ""),
                        Ingredient(id: "ing2",
                                   name: "Olive Oil",
                                   IngreimageUrl: "",
                                   quantityPerServing: "",
                                   quantity: "2 tbsp",
                                   category: "Oil & Dressings", checked: "")
                   ]
            ),
            Recipe(id: "recipe2",
                   name: "Easy Korean Beef",
                   imageURL: "https://example.com/korean_beef.jpg",
                   servings: 2,
                   ingredients: [
//                    Ingredient(id: "ing1",
//                               name: "Ground Bee",
//                               IngreimageUrl: "",
//                               quantityPerServing: "",
//                               quantity: "1 lb",
//                               category: "Meat & Seafood", checked: ""),
                    Ingredient(id: "ing3",
                               name: "Soy Sauce",
                               IngreimageUrl: "",
                               quantityPerServing: "",
                               quantity: "3 tbsp",
                               category: "Spices & Seasonings", checked: ""),
                   ]
            ),
//            Recipe(id: "recipe3",
//                   name: "HtanMinKyaw",
//                   imageURL: "https://example.com/cauliflower_rice.jpg",
//                   servings: 8,
//                   ingredients: [
//                    Ingredient(id: "ing1",
//                               name: "MM Foods",
//                               IngreimageUrl: "",
//                               quantityPerServing: "",
//                               quantity: "1 lb",
//                               category: "Meat & Seafood",
//                               checked: ""
//                              ),
//                   ]
//            ),
        ]
    }
}

// MARK: - Ingredient
struct Ingredient: Codable {
    var id,
        name,
        IngreimageUrl,
        quantityPerServing,
        quantity,
        category: String,
        checked: String
}
