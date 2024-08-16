//
//  Optionals.swift
//  Recipe
//
//  Created by kukuzan on 14/08/2024.
//

import Foundation

public extension Optional where Wrapped == Bool {
    
    var orFalse: Bool {
        switch self {
        case .none: return false
        case .some(let v): return v
        }
    }
}
