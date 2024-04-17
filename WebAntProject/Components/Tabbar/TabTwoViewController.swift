//
//  TabTwoViewController.swift
//  WebAntProject
//
//  Created by Евгений Мазурок on 15.04.2024.
//

import UIKit

class TabTwoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.title = "Popular"
        self.view.backgroundColor = UIColor.green
    }
}
