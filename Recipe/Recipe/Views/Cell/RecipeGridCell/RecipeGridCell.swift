//
//  RecipeGridCell.swift
//  Recipe
//
//  Created by Thant Sin Htun on 25/08/2024.
//

import UIKit

class RecipeGridCell: UITableViewCell {

    @IBOutlet weak var lblRecipeTitle: UILabel!
    @IBOutlet weak var cvRecipe: DynamicHeightCV!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()

    }
    private func setupViews(){
        lblRecipeTitle.font = .popSemiB16
        cvRecipe.register(cell: RecipeGridItemCell.self)
        cvRecipe.delegate = self
        cvRecipe.dataSource = self
        cvRecipe.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        cvRecipe.layoutIfNeeded()
    }
    
}

extension RecipeGridCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeGridItemCell", for: indexPath) as? RecipeGridItemCell
        guard let cell = cell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
extension RecipeGridCell : UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.width / 2 - 32 - 16, height: 287)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

