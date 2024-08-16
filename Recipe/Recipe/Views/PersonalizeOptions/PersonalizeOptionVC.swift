//
//  PersonalizeOptionVC.swift
//  Recipe
//
//  Created by kukuzan on 05/08/2024.
//

import UIKit

class PersonalizeOptionVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dietTitleLabel: UILabel!
    @IBOutlet weak var ingredientTitleLabel: UILabel!
   
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    // MARK: - Properties
    /// initialize
    let dummyRecipes = DummyData.dummyRecipes()
    let dummyIngredients = DummyData.dummyIngredients()
    var selectedIngredients: [DummyData] = [] {
        didSet {
            updateContinueButtonState()
        }
    }
    
    var selectedRecipe: DummyData? {
        didSet {
            recipesCollectionView.reloadData()
            updateContinueButtonState()
        }
    }
    
    // MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateContinueButtonState()
        viewDidLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ingredientsCollectionView.reloadData()
        recipesCollectionView.reloadData()
    }
    
    // MARK: - UI setup & Helper Functions
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        titleLabel.font = .popSemiB24
        dietTitleLabel.font = .popR14
        ingredientTitleLabel.font = .popR14
        btnSkip.setButtonTitleStyle(.popM12, .primary)
        btnSkip.setTitleUnderLine(title: "SKIP")
        btnContinue.backgroundColor = .activeOrange
        btnContinue.setButtonTitleStyle(.popSemiB14, .pureWhite)
        setupRecipesCollectionView()
        setupIngredientCollectinView()
    }

    private func setupRecipesCollectionView() {
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        recipesCollectionView.register(cell: PersonalizeRecipesCell.self)
        recipesCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        recipesCollectionView.reloadData()
    }
    
    private func setupIngredientCollectinView() {
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.allowsMultipleSelection = true
        ingredientsCollectionView.register(cell: PersonalizeIngredientsCell.self)
        let layout = CollectionViewFlowLayout(
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 50)
        )
        ingredientsCollectionView.collectionViewLayout = layout
    }
    
    private func updateContinueButtonState() {
        if selectedRecipe != nil && !selectedIngredients.isEmpty {
            btnContinue.isEnabled = true
            btnContinue.backgroundColor = .activeOrange
        } else {
            btnContinue.isEnabled = false
            btnContinue.backgroundColor = .lightGray
        }
    }
    
    // MARK: - IBActions
    @IBAction
    private func didTapContinue(_ sender: UIButton) {
        let personalizeGoalsVC = PersonalizeGoalsVC()
        navigationController?.pushViewController(personalizeGoalsVC, animated: true)
    }
    
    @IBAction
    private func didTapSkip(_ sender: UIButton) {
        let personalizeGoalsVC = PersonalizeGoalsVC()
        navigationController?.pushViewController(personalizeGoalsVC, animated: true)
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout
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
// MARK: - UICollectionViewDelegate
extension PersonalizeOptionVC: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if collectionView == ingredientsCollectionView {
            let selectedItem = dummyIngredients[indexPath.item]
            
            if let index = selectedIngredients.firstIndex(where: { $0.id == selectedItem.id }) {
                // Deselect the item
                selectedIngredients.remove(at: index)
            } else {
                // Select the item
                selectedIngredients.append(selectedItem)
            }
            UIView.performWithoutAnimation { [weak self] in
                self?.ingredientsCollectionView.reloadItems(at: [indexPath])
            }
        } else {
            let recipesSelectedItem = dummyRecipes[indexPath.row]
            selectedRecipe = recipesSelectedItem
        }
    }
}
// MARK: - UICollectionViewDataSource
extension PersonalizeOptionVC: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return collectionView == recipesCollectionView ?
        dummyRecipes.count :
        dummyIngredients.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == recipesCollectionView {
            let cell = collectionView.deque(
                PersonalizeRecipesCell.self,
                index: indexPath
            )
            let recipeItem = dummyRecipes[indexPath.row]
            let isSelected = recipeItem.id == selectedRecipe?.id
            cell.bind(data: recipeItem)
            cell.setSelectedState(isSelected)
            return cell
        } else {
            let cell = collectionView.deque(
                PersonalizeIngredientsCell.self,
                index: indexPath
            )
            let ingredientsItem = dummyIngredients[indexPath.item]
            let selectedIngredientsContain = selectedIngredients.contains { element in
                return element.id == ingredientsItem.id
            }
            cell.render(
                flag: selectedIngredientsContain,
                title: ingredientsItem.title
            )
            return cell
        }
    }

}

