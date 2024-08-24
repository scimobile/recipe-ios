//
//  RecipeHorizontalCell.swift
//  Recipe
//
//  Created by Thant Sin Htun on 24/08/2024.
//

import UIKit

class RecipeHorizontalCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvRecipe: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()

    }
    private func setupViews(){
        lblTitle.font = .popSemiB16
        cvRecipe.register(cell: RecipeItemCell.self)
        cvRecipe.delegate = self
        cvRecipe.dataSource = self
        cvRecipe.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

extension RecipeHorizontalCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeItemCell", for: indexPath) as? RecipeItemCell
        guard let cell = cell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
extension RecipeHorizontalCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.7, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
