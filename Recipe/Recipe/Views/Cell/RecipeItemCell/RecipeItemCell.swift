//
//  RecipeItemCell.swift
//  Recipe
//
//  Created by Thant Sin Htun on 24/08/2024.
//

import UIKit

class RecipeItemCell: UICollectionViewCell {

    @IBOutlet weak var viewBody: UIView!
    @IBOutlet weak var viewStar: StarRatingView!
    @IBOutlet weak var ivBlogger: UIImageView!
    @IBOutlet weak var ivRecipe: UIImageView!
    @IBOutlet weak var lblRecipeName: UILabel!
    @IBOutlet weak var btnAddRecipe: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    private func setupViews(){
        lblRecipeName.font = .popSemiB14
        btnAddRecipe.titleLabel?.font = .popSemiB11
        ivBlogger?.layer.cornerRadius = (ivBlogger?.frame.size.width ?? 0.0) / 2
        ivBlogger?.clipsToBounds = true
        ivBlogger?.layer.borderWidth = 3.0
        ivBlogger?.layer.borderColor = UIColor.white.cgColor
        viewBody.dropShadow()
        viewBody.borderStyle(width: 2, borderColor: UIColor.lightGray.alpha(0.1))
    }
}
