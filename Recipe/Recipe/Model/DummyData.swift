//
//  DummyRecipes.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

class DummyData {
    let id: Int
    let icon: UIImage?
    let title: String
    
    init(id: Int = 0,icon: UIImage? = nil, title: String) {
        self.id = id
        self.icon = icon
        self.title = title
    }
    
    static func dummyRecipes() -> [DummyData] {
        return [
            .init(id: 1, icon: .icVegetable, title: "Normal"),
            .init(id: 2, icon: .icVegan, title: "Vegan"),
            .init(id: 3, icon: .icVegetarian, title: "Vegetarian"),
            .init(id: 4, icon: .icMeat, title: "Pescatarian"),
            .init(id: 5, icon: .icPaleo, title: "Paleo"),
            .init(id: 6, icon: .icLowcrab, title: "Low-Carb"),
            .init(id: 7, icon: .icKeto, title: "Keto")
        ]
    }
    
    static func dummyGoals() -> [DummyData] {
        return [
            .init(id: 1, icon: .icHealth, title: "Eat Healthy"),
            .init(id: 2, icon: .icBudget, title: "Budget-Friendly"),
            .init(id: 3, icon: .icPlan, title: "Plan Better"),
            .init(id: 4, icon: .icLearn, title: "Quick & Easy"),
            .init(id: 5, icon: .icQuick, title: "Quick & Easy")
        ]
    }
    
    static func dummyIngredients() -> [DummyData] {
        return [
            .init(id: 1, title: "Gluten"),
            .init(id: 2, title: "Dairy"),
            .init(id: 3, title: "Egg"),
            .init(id: 4, title: "Soy"),
            .init(id: 5, title: "Peanut"),
            .init(id: 6, title: "Tree Nut"),
            .init(id: 7, title: "Fish"),
            .init(id: 8, title: "Shellfish"),
        ]
    }
}
