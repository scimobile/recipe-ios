//
//  TabbarVC.swift
//  Recipe
//
//  Created by Thant Sin Htun on 23/08/2024.
//

import UIKit

class TabbarVC: UITabBarController {

    init(){
        super.init(nibName: nil, bundle: nil)
        tabBar.items?.forEach {
            $0.titlePositionAdjustment = .init()
            $0.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
            $0.imageInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0)
            
        }
        tabBar.tintColor = UIColor.colorPrimary
        tabBar.unselectedItemTintColor = UIColor.darkGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var homeVC : HomeVC {
        var vc = HomeVC()
        vc.tabBarItem = UITabBarItem(title: "For You", image: UIImage(resource: .icTabbarHome), selectedImage: UIImage(resource: .icTabbarHomeSelected))
        return vc
    }
    var searchVC : SearchVC {
        var vc = SearchVC()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(resource: .icTabbarSearch), selectedImage: UIImage(resource: .icTabbarSearchSelected))
        return vc
    }
    var favouriteVC : FavouriteVC {
        var vc = FavouriteVC()
        vc.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(resource: .icTabbarFavourite), selectedImage: UIImage(resource: .icTabbarFavouriteSelected))
        return vc
    }
    var settingsVC : SettingsVC {
        var vc = SettingsVC()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(resource: .icTabbarSettings), selectedImage: UIImage(resource: .icTabbarSettingsSelected))
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        viewControllers = [
            homeVC,searchVC,favouriteVC,settingsVC
        ]
    }



}
