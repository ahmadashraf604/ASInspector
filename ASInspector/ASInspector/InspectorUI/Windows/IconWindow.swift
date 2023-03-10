//
//  IconWindow.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class IconWindow: BaseWindow {
  
  private lazy var showButton: UIButton = getShowButton()
  private let raduis: CGFloat = 50
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(
    uiHelpers: UIHelpers = .shared
  ) {
    let bounds = UIScreen.main.bounds
    let cornarRadias = raduis / 2
    let minX = bounds.size.width - raduis - 8
    let minY = (bounds.size.height / 2) - cornarRadias
    let frame = CGRect(x: minX, y: minY, width: raduis, height: raduis)
    if let windowScene = uiHelpers.windowScene {
      super.init(windowScene: windowScene)
    } else {
      super.init(frame: frame)
    }
    self.frame = frame
    backgroundColor = UIColor.clear
    windowLevel = UIWindow.Level(UIWindow.Level.alert.rawValue + 2)
    rootViewController = UIViewController()
    rootViewController?.view.addSubview(showButton)
    rootViewController?.view.bringSubviewToFront(showButton)
  }
  
  @objc private func showLoggerView() {
    print("show")
  }
}

// MARK: - Private Helpers
private extension IconWindow {
  func getShowButton() -> UIButton {
    let cornarRadias = raduis / 2
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    button.setInsets(forContentPadding: .init(inset: raduis * 0.2))
    button.setImage(AppImages.inspectorIcon, for: .normal)
    button.tintColor = AppColors.white
    button.backgroundColor = AppColors.primary
    button.layer.cornerRadius = cornarRadias
    button.addTarget(self, action: #selector(showLoggerView), for: .touchUpInside)
    return button
  }
}
