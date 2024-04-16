//
//  ViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
            super.viewDidLoad()

            self.delegate = self
            self.tabBar.backgroundColor = UIColor.white
            self.tabBar.tintColor = UIColor.red

        let tabOne = TabOneViewController()
        let tabOneNavigationController = UINavigationController(rootViewController: tabOne)
        let tabOneBarItem = UITabBarItem(title: "New", image: UIImage(named: "defaultImage.png"),
                                         selectedImage: UIImage(named: "selectedImage.png"))
        tabOneNavigationController.tabBarItem = tabOneBarItem

        let tabTwo = TabTwoViewController()
        let tabTwoNavigationController = UINavigationController(rootViewController: tabTwo)
        let tabTwoBarItem = UITabBarItem(title: "Popular", image: UIImage(named: "defaultImage2.png"),
                                         selectedImage: UIImage(named: "selectedImage2.png"))
        tabTwoNavigationController.tabBarItem = tabTwoBarItem

        self.viewControllers = [tabOneNavigationController, tabTwoNavigationController]

        }

}
