//
//  UIBaseTabBarController.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class UIBaseTabBarController: UITabBarController {
  let tabs: [Tabs]
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(tabs: Tabs...) {
    self.tabs = tabs
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let viewControllers = tabs.map( { $0.ViewController })
    self.viewControllers = viewControllers
  }
}

// MARK: - UITabBarControllerDelegate
extension UIBaseTabBarController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    print("didSelect \(item)")
  }
}
