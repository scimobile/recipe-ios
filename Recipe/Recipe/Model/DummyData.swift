//
//  DummyRecipes.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

class DummyData {
    let icon: UIImage
    let title: String
    
    init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }
    
    static func dummyRecipes() -> [DummyData] {
        return [
            .init(icon: .icVegetable, title: "Normal"),
            .init(icon: .icVegan, title: "Vegan"),
            .init(icon: .icVegetarian, title: "Vegetarian"),
            .init(icon: .icMeat, title: "Pescatarian"),
            .init(icon: .icPaleo, title: "Paleo"),
            .init(icon: .icLowcrab, title: "Low-Carb"),
            .init(icon: .icKeto, title: "Keto")
        ]
    }
    
    static func dummyGoals() -> [DummyData] {
        return [
            .init(icon: .icHealth, title: "Eat Healthy"),
            .init(icon: .icBudget, title: "Budget-Friendly"),
            .init(icon: .icPlan, title: "Plan Better"),
            .init(icon: .icLearn, title: "Quick & Easy"),
            .init(icon: .icQuick, title: "Quick & Easy")
        ]
    }
}
