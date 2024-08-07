//
//  PersonalizeOptionVC.swift
//  Recipe
//
//  Created by kukuzan on 05/08/2024.
//

import UIKit

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

class PersonalizeOptionVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dietTitleLabel: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    let dummyRecipes = DummyRecipes.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        titleLabel.font = .popSemiB24
        dietTitleLabel.font = .popR14
        btnSkip.setButtonTitleStyle(.popM12, .primary)
        btnSkip.setTitleUnderLine(title: "SKIP")
        setupCollectionView()
    }

    private func setupCollectionView() {
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.register(cell: PersonalizeRecipesCell.self)
        recipesCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

}

extension PersonalizeOptionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width/4 + 8, height: 116)
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
