//
//  FlexibleGridViewComponents.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

public protocol UIFlexibleGridViewDataSource: AnyObject {
    func layoutForGridView(_ flexibleGridView: UIFlexibleGridView) -> UIGridLayout
    func numberOfItemsInGridView(_ flexibleGridView: UIFlexibleGridView) -> Int
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, itemForIndexAt index: Int) -> UIFlexibleGridViewItem
}

public protocol UIFlexibleGridViewDelegate: AnyObject {
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, didSelectItemAt index: Int)
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, contentHeight height: CGFloat)
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, widthForItemAt index: Int) -> CGFloat
}

public extension UIFlexibleGridViewDelegate {
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, didSelectItemAt index: Int) {}
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, contentHeight height: CGFloat) {}
    func flexibleGridView(_ flexibleGridView: UIFlexibleGridView, widthForItemAt index: Int) -> CGFloat { return 0 }
}

public class UIFlexibleGridViewItemSelector: UITapGestureRecognizer {
    let item: UIFlexibleGridViewItem
    
    init(target: AnyObject, action: Selector, item: UIFlexibleGridViewItem) {
        self.item = item
        super.init(target: target, action: action)
    }
}

public class UIFlexibleGridViewItemEditor: UILongPressGestureRecognizer {
    let item: UIFlexibleGridViewItem
    
    init(target: AnyObject, action: Selector, item: UIFlexibleGridViewItem) {
        self.item = item
        super.init(target: target, action: action)
    }
}

public enum UIFlexibleGridViewAlignment {
    case left
    case center
    case justify
    case right
    
    var value: UIStackView.Alignment {
        switch self {
        case .left:
            return .leading
        case .center:
            return .center
        case .justify:
            return .fill
        case .right:
            return .trailing
        }
    }
}

public enum UIFlexibleGridViewSelectionStyle {
    case none
    case single
    case multiple
}

public enum UIGridLayout {
    case auto
    case custom
}

public struct UIGridInsets {
    let top: CGFloat
    let left: CGFloat
    let bottom: CGFloat
    let right: CGFloat
    
    init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}
