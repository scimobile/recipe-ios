//
//  RecipeCardCell.swift
//  Recipe
//
//  Created by user on 21/08/2024.
//

import UIKit
import RealmSwift

class RecipeCardCell: UITableViewCell {
    
    // MARK: Properties
    static let identifier = "RecipeCardCell"
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var cartCollectionView: UICollectionView!
    private var vm: CartVM = CartVM.shared
    private weak var delegate: RecipeCardViewCellDelegate?
    
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setupShadow()
    }
    
    private func setupShadow() {
        contentView.dropShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cartCollectionView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width - 10, height: 250)
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
    }
    
    // MARK: Setup Methods
    private func setupCollectionView() {
        cartCollectionView.register(UINib(nibName: "RecipeCardViewCell", bundle: nil), forCellWithReuseIdentifier: RecipeCardViewCell.identifier)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        cartCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        selectionStyle = .none
    }
    
    // MARK: Configure
    func configure(with model: [RecipeObject], delegate: RecipeCardViewCellDelegate) {
        let totalRecipes = model.count
        let totalItems = model.reduce(0) { $0 + $1.ingredients.count }
        recipeTitle.text = "\(totalRecipes) Recipes ● \(totalItems) Items"
        cartCollectionView.reloadData()
        self.delegate = delegate
    }
}

// MARK: UICollectionView Delegate & DataSource
extension RecipeCardCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vm.recipeObjects.isEmpty {
            return 0
        }
        return vm.recipeObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recipeObj = vm.recipeObjects
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCardViewCell.identifier, for: indexPath) as! RecipeCardViewCell
        cell.config(with: recipeObj[indexPath.row], delegate: self.delegate)
        return cell
    }
    
    private func updateUIForEmptyState() {
        if vm.recipeObjects.isEmpty {
            cartCollectionView.isHidden = true 
        } else {
            cartCollectionView.isHidden = false
        }
    }
}

// MARK: UICollectionView DelegateFlowLayout
extension RecipeCardCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
