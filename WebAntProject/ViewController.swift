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
            let tabOneBarItem = UITabBarItem(title: "New", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
            tabOne.tabBarItem = tabOneBarItem

            let tabTwo = TabTwoViewController()
            let tabTwoBarItem2 = UITabBarItem(title: "Popular", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))

            tabTwo.tabBarItem = tabTwoBarItem2
            self.viewControllers = [tabOne, tabTwo]
        }

        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("Selected \(viewController.title ?? "")")
        }
}
