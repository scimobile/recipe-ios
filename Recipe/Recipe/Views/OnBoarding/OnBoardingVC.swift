//
//  OnBoardingVC.swift
//  Recipe
//
//  Created by Thant Sin Htun on 07/08/2024.
//

import UIKit

class OnBoardingVC: UIViewController {
    


    @IBOutlet weak var cvOnBoarding: UICollectionView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var viewGetStart: UIView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGetStart: UIButton!
    @IBOutlet weak var indicator: UIPageControl!
    
    private let onBoardingList = 
    [
        OnBoardingEntity(
            title: "Personalized Recipe \n Discovery",
            content: "Tell us your food preferences and we’ll only serve you delicious recipes ideas.",
            image: "onboard1"
        ),
        OnBoardingEntity(
            title: "Never Forget an Ingredient",
            content: "Build your weekly grocery list and stay organized while you shop.",
            image: "onboard2"
        ),
        OnBoardingEntity(
            title: "Your Favourite Recipes at \nYour Fingertips",
            content: "Save time on planning by having your favourite recipes always within reach.",
            image: "onboard3"
        )
    ]
    
    var currentPage = 0 {
        didSet {
            if currentPage == onBoardingList.count - 1 {
                viewNext.isHidden = true
                
                UIView.transition(with: viewGetStart, duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.viewGetStart.isHidden = false
                })
                
            } else {
                viewNext.isHidden = false
                UIView.transition(with: viewGetStart, duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.viewGetStart.isHidden = true
                })
            }
            indicator.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        initBindings()
    }
    
    private func setupViews(){
        currentPage = 0
        cvOnBoarding.register(cell: OnBoardingCell.self)
        cvOnBoarding.delegate = self
        cvOnBoarding.dataSource = self
        indicator.numberOfPages = onBoardingList.count
        btnNext.titleLabel?.font = .popB12
        btnGetStart.titleLabel?.font = .popB12

        let underlineAttribute = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.popR12
        ] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: "LOG IN", attributes: underlineAttribute)
        btnLogin.setAttributedTitle(underlineAttributedString, for: .normal)
        

    }
    
    private func initBindings(){
        btnNext.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        btnGetStart.addTarget(self, action: #selector(onTapGetStart), for: .touchUpInside)

    }
   
    @objc private func onTapNext(){
        if currentPage < onBoardingList.count - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            cvOnBoarding.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    @objc private func onTapLogin(){
        navigateToLoginSelect()
    }
    @objc private func onTapGetStart(){
        navigateToLoginSelect()
    }

    private func navigateToLoginSelect(){
        self.navigationController?.pushViewController(LoginSelectVC(), animated: true)
    }

}

extension OnBoardingVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCell", for: indexPath) as? OnBoardingCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.setData(with: onBoardingList[indexPath.row])
        return cell
    }
    
    
}
extension OnBoardingVC : UICollectionViewDelegate {
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
extension OnBoardingVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: cvOnBoarding.bounds.width, height: cvOnBoarding.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
