//
//  SplashVC.swift
//  Recipe
//
//  Created by Thant Sin Htun on 08/08/2024.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var lblDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews()  {
        lblDesc.font = .popSemiB24
        let animationViewSub = LottieAnimationView(name: "splashAnimation")
        animationViewSub.contentMode = .scaleAspectFit
        animationViewSub.frame = animationView.bounds
        animationViewSub.loopMode = .loop
        animationView.addSubview(animationViewSub)
        animationViewSub.play()

    }


}
