//
//  PersonalizeOptionVC.swift
//  Recipe
//
//  Created by kukuzan on 05/08/2024.
//

import UIKit

class PersonalizeOptionVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dietTitleLabel: UILabel!
    @IBOutlet weak var ingredientTitleLabel: UILabel!
   
    @IBOutlet weak var flexibleGridView: UIFlexibleGridView!
    @IBOutlet weak var flexibleGridViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    let dummyRecipes = DummyRecipes.dummy()
    let dummyIngredients = [
        "Gluten",
        "Dairy",
        "Egg",
        "Soy",
        "Peanut",
        "Tree Nut",
        "Fish",
        "Shellfish"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        titleLabel.font = .popSemiB24
        dietTitleLabel.font = .popR14
        ingredientTitleLabel.font = .popR14
        btnSkip.setButtonTitleStyle(.popM12, .primary)
        btnSkip.setTitleUnderLine(title: "SKIP")
        btnContinue.backgroundColor = .activeOrange
        btnContinue.setButtonTitleStyle(.popSemiB14, .pureWhite)
        setupCollectionView()
        setupFlexibleGridView()
    }

    private func setupCollectionView() {
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.register(cell: PersonalizeRecipesCell.self)
        recipesCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private func setupFlexibleGridView() {
        flexibleGridView.dataSource = self
        flexibleGridView.delegate = self
        flexibleGridView.itemHeight = 40
        flexibleGridView.itemSpacing = 16
        flexibleGridView.lineSpacing = 12
        flexibleGridView.selectionStyle = .single
        flexibleGridView.contentInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        flexibleGridView.register(with: UIFlexibleGridViewItem.self, identifier: "flexible-item")
        flexibleGridView.reloadData()
    }
    
}

extension PersonalizeOptionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width/4 - 8, height: 116)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        8
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
}

extension PersonalizeOptionVC: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(dummyRecipes[indexPath.row])
    }
}

extension PersonalizeOptionVC: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dummyRecipes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.deque(
            PersonalizeRecipesCell.self,
            index: indexPath
        )
        cell.bind(data: dummyRecipes[indexPath.row])
        return cell
    }

}

extension PersonalizeOptionVC: UIFlexibleGridViewDataSource, UIFlexibleGridViewDelegate {
    
    func layoutForGridView(
        _ flexibleGridView: UIFlexibleGridView
    ) -> UIGridLayout {
        return .auto
    }
    
    func numberOfItemsInGridView(
        _ flexibleGridView: UIFlexibleGridView
    ) -> Int {
        return dummyIngredients.count
    }
    
    func flexibleGridView(
        _ flexibleGridView: UIFlexibleGridView,
        itemForIndexAt index: Int
    ) -> UIFlexibleGridViewItem {
        let item = flexibleGridView.dequeItem(withIdentifier: "flexible-item", for: index)
        item.setChipStyle(with: dummyIngredients[index])
        return item
    }
    
    func flexibleGridView(
        _ flexibleGridView: UIFlexibleGridView,
        didSelectItemAt index: Int
    ) {
        print(index)
    }
    
    func flexibleGridView(
        _ flexibleGridView: UIFlexibleGridView,
        contentHeight height: CGFloat
    ) {
        flexibleGridViewHeight.constant = height
    }

}
