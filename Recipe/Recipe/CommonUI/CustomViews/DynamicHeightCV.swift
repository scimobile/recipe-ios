//
//  DynamicHeightCV.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

class DynamicHeightCV: UICollectionView {
    var maxHeight = CGFloat.greatestFiniteMagnitude
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        
        let height = min(contentSize.height, maxHeight)
        return .init(width: UIScreen.main.bounds.width, height: height)
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
}
