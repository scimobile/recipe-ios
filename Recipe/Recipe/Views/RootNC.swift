//
//  RootNC.swift
//  Recipe
//
//  Created by Thant Sin Htun on 22/08/2024.
//

import UIKit

class RootNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.navigateToOnBoarding()
        }
    }
    
    private func navigateToOnBoarding(){
        pushViewController(OnBoardingVC(), animated: true)
    }
}
