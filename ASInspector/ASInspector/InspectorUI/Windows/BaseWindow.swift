//
//  BaseWindow.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class BaseWindow: UIWindow {
  private weak var preKeyWindow: UIWindow?
  private let uiHelpers: UIHelpers = .shared
  private let uiManager: UIManager = .shared
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init() {
    super.init(frame: .zero)
    if #available(iOS 13.0, *) {
      self.windowScene = uiHelpers.keyWindow?.windowScene
    }
    self.windowLevel = .init(CGFloat.greatestFiniteMagnitude)
  }
  
  func present(rootVC: UIViewController) {
    layoutMargins = .zero
    backgroundColor = .white
    clipsToBounds = true
    directionalLayoutMargins = .zero
    insetsLayoutMarginsFromSafeArea = false
    rootViewController = rootVC
    makeKeyAndVisible()
    let presentTransition = CATransition()
    presentTransition.duration = 0.37
    presentTransition.timingFunction = CAMediaTimingFunction(name: .easeOut)
    presentTransition.type = .moveIn
    presentTransition.subtype = .fromTop
    layer.add(presentTransition, forKey: kCATransition)
  }
  
  func dismiss(completion: (() -> Void)?) {
    preKeyWindow?.makeKey()
    preKeyWindow = nil
    let isMiniModeActive = uiManager.isMiniModeActive
    let animationDuration: TimeInterval = isMiniModeActive ? 0.2 : 0.3
    let height = uiHelpers.defaultBounds.height
    UIView.animate(withDuration: animationDuration, delay: .zero, options: [.curveEaseIn], animations: { [weak self] in
      guard let self = self else { return }
      if isMiniModeActive {
        self.alpha = 0
      } else {
        self.frame.origin.y = height
        self.alpha = 0.5
      }
    }, completion: { [weak self] (completed) in
      self?.isHidden = true
      self?.rootViewController = nil
      completion?()
    })
  }
}
