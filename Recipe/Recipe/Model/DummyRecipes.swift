//
//  DummyRecipes.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import Foundation

class DummyRecipes {
    let icon: UIImage
    let title: String
    
    init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }
    
    static func dummy() -> [DummyRecipes] {
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
}
