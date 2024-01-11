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
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 78/255, green: 99/255, blue: 145/255, alpha: 1.0)
        
    tabBar.standardAppearance = tabBarAppearance
    }
}

extension UIColor {
    public class var darkBlue: UIColor { UIColor(red: 6/255, green: 33/255, blue: 89/255, alpha: 1.0) }
    public class var backgroundBlue: UIColor { UIColor(red: 149/255, green: 172/255, blue: 224/255, alpha: 1.0) }
    // TODO: - додати кольори
}
