//
//  NSObject.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
