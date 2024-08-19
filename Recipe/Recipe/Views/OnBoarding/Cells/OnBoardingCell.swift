//
//  OnBoardingCell.swift
//  Recipe
//
//  Created by Thant Sin Htun on 07/08/2024.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {

    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var imgOnBoard: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(with entity:OnBoardingEntity){
        lblTitle.text = entity.title
        lblTitle.font = .popSemiB20
        lblContent.text = entity.content
        lblContent.font = .popR12
        imgOnBoard.image = UIImage(named: entity.image)
    }

}
