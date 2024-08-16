//
//  UIFlexibleGridViewItem.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

open class UIFlexibleGridViewItem: UIView {
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondary
        label.font = .popM14
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var isSelected: Bool = false
    
    public required init() {
        super.init(frame: CGRect.zero)
        initView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func onSelected() {
        isSelected = true
        backgroundColor = .activeOrange
        layer.borderColor = UIColor.clear.cgColor
        titleLabel.textColor = .white
    }
    
    open func onDeselected() {
        isSelected = false
        backgroundColor = .clear
        layer.borderColor = UIColor.secondary.cgColor
        titleLabel.textColor = .secondary
    }
    
    open func initView() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.secondary.cgColor
        self.clipsToBounds = true
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4)
        ])
    }
    
    public func setChipStyle(with text: String?) {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderColor = UIColor.secondary.cgColor
        titleLabel.text = text
        titleLabel.font = .popM14
    }
}
