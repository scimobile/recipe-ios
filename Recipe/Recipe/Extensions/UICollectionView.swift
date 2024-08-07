//
//  UICollectionView.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

extension UICollectionView {
    func deque<cell: UICollectionViewCell>(_ cell: cell.Type, index: IndexPath) -> cell {
        return dequeueReusableCell(withReuseIdentifier: cell.className, for: index) as! cell
    }
    
    func register<cell: UICollectionViewCell>(cell: cell.Type) {
        register(.init(nibName: cell.className, bundle: nil), forCellWithReuseIdentifier: cell.className)
    }
}
