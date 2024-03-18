//
//  TabBarViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 10.01.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
    super.viewDidLoad()

    let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.darkBlue
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.grayBLue
        
    tabBar.standardAppearance = tabBarAppearance
    }
}


