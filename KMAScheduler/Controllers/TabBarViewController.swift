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
    public class var backgroundBlue: UIColor { UIColor(red: 222/255, green: 232/255, blue: 255/255, alpha: 1.0) }
    public class var lightBlue: UIColor { UIColor(red: 235/255, green: 242/255, blue: 255/255, alpha: 1.0) }
    public class var brightBlue: UIColor { UIColor(red: 13/255, green: 82/255, blue: 191/255, alpha: 1.0) }
}
