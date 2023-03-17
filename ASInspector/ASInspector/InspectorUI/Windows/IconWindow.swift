//
//  IconWindow.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class IconWindow: BaseWindow {
  private let uiHelpers: UIHelpers = .shared
  private let uiManager: UIManager = .shared
  private lazy var showButton: UIButton = getShowButton()
  private let radius: CGFloat = 50
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override init() {
    let bounds = UIScreen.main.bounds
    let cornarRadius = radius / 2
    let minX = bounds.size.width - radius - 8
    let minY = (bounds.size.height / 2) - cornarRadius
    let frame = CGRect(x: minX, y: minY, width: radius, height: radius)
    super.init()
    self.frame = frame
    backgroundColor = UIColor.clear
    windowLevel = UIWindow.Level(UIWindow.Level.alert.rawValue + 2)
    rootViewController = UIViewController()
    rootViewController?.view.addSubview(showButton)
    rootViewController?.view.bringSubviewToFront(showButton)
  }
  
  @objc private func showLoggerView() {
    UIManager.shared.presentUI()
  }
  
  weak var mainWindow: UIWindow?
  override func becomeKey() {
    super.becomeKey()
    mainWindow?.makeKey()
      }
}

// MARK: - Private Helpers
private extension IconWindow {
  func getShowButton() -> UIButton {
    let cornerRadius = radius / 2
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    button.setInsets(forContentPadding: .init(inset: radius * 0.2))
    button.setImage(AppImages.inspectorIcon, for: .normal)
    button.tintColor = AppColors.white
    button.backgroundColor = AppColors.primary
    button.layer.cornerRadius = cornerRadius
    button.addTarget(self, action: #selector(showLoggerView), for: .touchUpInside)
    return button
  }
}
