//
//  PersonalizeOptionVC.swift
//  Recipe
//
//  Created by kukuzan on 05/08/2024.
//

import UIKit

class PersonalizeOptionVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    private func setupUI() {
        titleLabel.font = .popSemiB24
        btnSkip.setButtonTitleStyle(.popM12, .primary)
        btnSkip.setTitleUnderLine(title: "SKIP")
    }

}
