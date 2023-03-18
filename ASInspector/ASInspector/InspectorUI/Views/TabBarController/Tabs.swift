//
//  Tabs.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 08/01/2023.
//

import UIKit

enum Tabs {
  case networkLogs
  case consoleLogs
  case settings
  
  var ViewController: UIViewController {
    let tabBarItem: UITabBarItem
    let viewController: UIViewController
    
    switch self {
    case .networkLogs:
      tabBarItem = UITabBarItem(title: "Network", image: AppImages.internetIcon, selectedImage: nil)
      viewController = NetworkLogsViewController()
    case .consoleLogs:
      tabBarItem = UITabBarItem(title: "Console", image: AppImages.commandLineIcon, selectedImage: nil)
      viewController = ConsoleLogsViewController()
    case .settings:
      tabBarItem = UITabBarItem(title: "Setting", image: AppImages.settingsIcon, selectedImage: nil)
      viewController = UIViewController()
    }
    viewController.tabBarItem = tabBarItem
    let navigationController = BaseNavigationController(rootViewController: viewController)
    return navigationController
  }
}
