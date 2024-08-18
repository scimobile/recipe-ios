//
//  PersonalizeGoalsVC.swift
//  Recipe
//
//  Created by kukuzan on 07/08/2024.
//

import UIKit

class PersonalizeGoalsVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var goalsCollectionView: DynamicHeightCV!
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    
    // MARK: - Properties
    /// initialize
    let dummyGoals = DummyData.dummyGoals()
    
    // MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    // MARK: - UI setup & Helper Functions
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        titleLabel.font = .popSemiB24
        selectTitleLabel.font = .popR14
        btnSkip.setButtonTitleStyle(.popM12, .primary)
        btnSkip.setTitleUnderLine(title: "SKIP")
        btnContinue.backgroundColor = .activeOrange
        btnContinue.setButtonTitleStyle(.popSemiB14, .pureWhite)
        setupCollectionView()
    }

    private func setupCollectionView() {
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
        goalsCollectionView.register(cell: PersonalizeGoalsCell.self)
        goalsCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // MARK: - IBActions
    @IBAction
    private func didTapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction
    private func didTapSkip(_ sender: UIButton) {
        
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension PersonalizeGoalsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(width: collectionView.frame.width/2 - 8 - 16, height: 140)
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
extension PersonalizeGoalsVC: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(dummyGoals[indexPath.row])
    }
}
// MARK: - UICollectionViewDataSource
extension PersonalizeGoalsVC: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dummyGoals.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.deque(
            PersonalizeGoalsCell.self,
            index: indexPath
        )
        cell.bind(data: dummyGoals[indexPath.row])
        return cell
    }

}
