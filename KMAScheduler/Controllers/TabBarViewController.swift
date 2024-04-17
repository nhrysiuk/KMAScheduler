//
//  TabBarViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 10.01.2024.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - View controllers lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    //MARK: - Set up
    private func setUp() {
        let schedule = makeController(with: UIImage(systemName: "calendar"), vc: ScheduleViewController())
        let settings = makeController(with: UIImage(systemName: "gearshape.fill"), vc: SettingsTableViewController())
        
        self.setViewControllers([schedule, settings], animated: true)
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .darkBlue
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .grayBLue
        tabBar.standardAppearance = tabBarAppearance
    }
    
    private func makeController(with image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        nav.navigationItem.backBarButtonItem?.tintColor = .darkBlue
        
        return nav
    }
}
