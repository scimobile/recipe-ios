//
//  UIFlexibleGridView.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

public class UIFlexibleGridView: UIView {
    
    //MARK:- SubViews
    private let scrollView: UIScrollView = UIScrollView()
    private let containerView: UIView = UIView()
    private var containerHeightConstraint: NSLayoutConstraint? = nil
    
    //MARK:-  PROPERTIES
    
    public weak var delegate: UIFlexibleGridViewDelegate?
    public weak var dataSource: UIFlexibleGridViewDataSource?
    
    public var itemSpacing: CGFloat = 4
    public var lineSpacing: CGFloat = 4
    public var itemHeight: CGFloat = 40
    public var contentInsets: UIGridInsets = UIGridInsets(top: 0, left: 0, bottom: 0, right: 0)

    public var alignment: UIFlexibleGridViewAlignment = .left
    public var selectionStyle: UIFlexibleGridViewSelectionStyle = .single
    
    public var showsScrollIndicator: Bool = true
    
    private var layout: UIGridLayout? = nil
    private var items: [UIFlexibleGridViewItem] = []
    private var registered: [String: UIFlexibleGridViewItem.Type] = [:]
    private var numberOfItems: Int = 0
    private var nibItem: UINib?
    
    //MARK:- INITIALIZATIONS
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        loadDataSource()
        loadView()
    }
    
    private func commonInit() {
        
        scrollView.showsVerticalScrollIndicator = showsScrollIndicator
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        containerHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 0)
        containerHeightConstraint?.isActive = true
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func loadView() {
        containerView.subviews
            .forEach { $0.removeFromSuperview() }
        
        let vStack = generateVStack()
        var hStack = generateHStack()
        
        var contentHeight: CGFloat = 0
        var rowWidth: CGFloat = 0
        for (index, item) in items.enumerated() {
            item.translatesAutoresizingMaskIntoConstraints = false
            
            var itemWidth: CGFloat = 0
            if layout! == .auto {
                itemWidth = item.titleLabel.intrinsicContentSize.width + 35
            } else {
                guard let delegate = delegate else { fatalError("Delegate Initialization not found.") }
                itemWidth = delegate.flexibleGridView(self, widthForItemAt: index)
            }
            rowWidth += itemWidth + itemSpacing
            
            let insets = contentInsets.left + contentInsets.right
            if rowWidth < frame.size.width - insets  {
                hStack.addArrangedSubview(item)
            } else {
                vStack.addArrangedSubview(hStack)
                hStack = generateHStack()
                hStack.addArrangedSubview(item)
                rowWidth = itemWidth + itemSpacing
            }
            
            if alignment != .justify {
                item.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
            }
            
            vStack.addArrangedSubview(hStack)
            let rowsCount = CGFloat(vStack.subviews.count)
            contentHeight = (rowsCount * itemHeight) + ((rowsCount - 1) * lineSpacing)
        }
        
        contentHeight += contentInsets.top + contentInsets.bottom
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: contentInsets.top),
            vStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: contentInsets.left),
            vStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -contentInsets.right),
            vStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -contentInsets.bottom),
        ])
        
        containerHeightConstraint?.constant = contentHeight
        scrollView.contentSize = CGSize(width: frame.width, height: contentHeight)
        
        delegate?.flexibleGridView(self, contentHeight: contentHeight)
    }
    
    private func loadDataSource() {
        guard let dataSource = dataSource else { return }
        layout = dataSource.layoutForGridView(self)
        numberOfItems = dataSource.numberOfItemsInGridView(self)
        
        items = []
        for index in 0..<numberOfItems {
            let item = dataSource.flexibleGridView(self, itemForIndexAt: index)
            self.configureGesutres(for: item)
            self.items.append(item)
        }
    }
    
    private func configureGesutres(for item: UIFlexibleGridViewItem) {
        item.isUserInteractionEnabled = true
        let tap = UIFlexibleGridViewItemSelector(target: self, action: #selector(didSelectItem(_:)), item: item)
        item.addGestureRecognizer(tap)
        let press = UIFlexibleGridViewItemEditor(target: self, action: #selector(didPressItem(_:)), item: item)
        item.addGestureRecognizer(press)
    }
    
    @objc fileprivate func didSelectItem(_ sender: UIFlexibleGridViewItemSelector) {
        delegate?.flexibleGridView(self, didSelectItemAt: sender.item.tag)
        
        let item = items[sender.item.tag]
        if selectionStyle != .none {
            item.onSelected()
            
            if selectionStyle == .single {
                _ = items.filter{ $0 != item }.map { $0.onDeselected() }
            }
        }
        
    }
    
    @objc fileprivate func didPressItem(_ sender: UIFlexibleGridViewItemEditor) {
        print("long press \(sender.item.tag)")
    }
    
    private func generateVStack() -> UIStackView {
        let vStack = UIStackView()
        vStack.alignment = alignment.value
        vStack.distribution = .fillEqually
        vStack.axis = .vertical
        vStack.spacing = lineSpacing
        return vStack
    }
    
    private func generateHStack() -> UIStackView {
        let hStack = UIStackView()
        hStack.alignment = .fill
        hStack.distribution = .fillProportionally
        hStack.axis = .horizontal
        hStack.spacing = itemSpacing
        return hStack
    }
    
    //MARK:- COMMUNICATION METHIODS
    
    public func register<UIFlexibleGridViewItemClass: UIFlexibleGridViewItem>(with item: UIFlexibleGridViewItemClass.Type, identifier: String) {
        registered[identifier] = UIFlexibleGridViewItemClass.self
    }
    
    public func registerNib<UIFlexibleGridViewItemClass: UIFlexibleGridViewItem>(with nib: UINib, item: UIFlexibleGridViewItemClass.Type, identifier: String) {
        nibItem = nib
        registered[identifier] = UIFlexibleGridViewItemClass.self
    }
    
    public func dequeItem(withIdentifier identifier: String, for index: Int) -> UIFlexibleGridViewItem {
        let isRegistered = registered.contains(where: { $0.key == identifier })
        if !isRegistered { fatalError("GridItem is not registered.") }
        
        if let nib = nibItem {
            let item = registered[identifier]!.init()
            let nibView = nib.instantiate(withOwner: item, options: nil).first as! UIView
            nibView.frame = item.bounds
            item.addSubview(nibView)
            item.tag = index
            return item
        } else {
            let item = registered[identifier]!.init()
            item.tag = index
            return item
        }
        
    }
    
    public func itemForIndexAt(index: Int) -> UIFlexibleGridViewItem {
        return items[index]
    }
    
    public func reloadData() {
        loadDataSource()
        loadView()
    }
    
}
