//
//  BaseHeaderView.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import Foundation

import UIKit

class BaseHeaderView: UIView {
  private let uiManager = UIManager.shared
  private let uiHelpers = UIHelpers.shared
  
  private lazy var baseStacView: UIStackView = getMainView()
  private lazy var safeAreaView: UIView = getSafeAreaView()
  private lazy var horizentalStackView: UIStackView = getHorizentalStackView()
  private lazy var leftBarView: UIStackView = getLeftStackView()
  private lazy var rightBarView: UIStackView = getRightStackView()
  private lazy var titleLabel: UILabel = getTitleView()
  
  private var safeAreaHeightContraint: NSLayoutConstraint?
  private var headerViewHeightConstraint: NSLayoutConstraint?
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    updateHeaderHeight()
  }
}

// MARK: - Private Helpers
private extension BaseHeaderView {
  var headerHeight: CGFloat {
    return 43
  }
  
  var ignoreStatusBarHeight: Bool {
    return uiManager.isMiniModeActive
  }
  
  func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    // Clear all constraints
    for constraint in self.constraints {
      self.removeConstraint(constraint)
    }
    addSubview(baseStacView)
    match(to: baseStacView, margin: .zero)
    
    safeAreaHeightContraint = safeAreaView.heightAnchor.constraint(equalToConstant: .zero)
    safeAreaHeightContraint?.priority = UILayoutPriority(999)
    safeAreaHeightContraint?.isActive = true
    headerViewHeightConstraint = heightAnchor.constraint(equalToConstant: headerHeight)
    headerViewHeightConstraint?.isActive = true
    
    backgroundColor = AppColors.primary
    layoutIfNeeded()
  }
  
  func updateHeaderHeight() {
    let statusBarHeight = uiHelpers.statusBarHeight
    headerViewHeightConstraint?.constant = headerHeight + statusBarHeight
    safeAreaHeightContraint?.constant = statusBarHeight
    layoutIfNeeded()
  }
}


// MARK: - Private View Helpers
private extension BaseHeaderView {
  func getMainView() -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: [safeAreaView, horizentalStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = .zero
    return stackView
  }
  
  func getSafeAreaView() -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
  
  func getHorizentalStackView() -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: [
      leftBarView, titleLabel, rightBarView
    ])
    configureStackView(stackView)
    titleLabel.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
    return stackView
  }
  
  func getLeftStackView() -> UIStackView {
    let stackView = UIStackView()
    configureStackView(stackView)
    return stackView
  }
  
  func getRightStackView() -> UIStackView {
    let stackView = UIStackView()
    configureStackView(stackView)
    return stackView
  }
  
  func getTitleView() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = AppColors.white
    label.font = .boldSystemFont(ofSize: 20)
    label.textAlignment = .center
    label.backgroundColor = .clear
    return label
  }
  
  func configureStackView(_ stackView: UIStackView) {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 5
    stackView.removeFromSuperview()
    self.addSubview(stackView)
  }
  
  func addBarButtonConstraints(_ item: UIView) {
    item.translatesAutoresizingMaskIntoConstraints = false
    item.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
    item.widthAnchor.constraint(equalToConstant: headerHeight).isActive = true
  }
  
}

// MARK: - Public Func
extension BaseHeaderView {
  
  func addBackButton(target: Any?, selector: Selector) {
    let insets = UIEdgeInsets(top: 11, left: 0, bottom: 11, right: 24)
    let backButton = uiHelpers.getNavigationButton(image: AppImages.backIcon, imageInsets: insets)
    backButton.addTarget(target, action: selector, for: .touchUpInside)
    addBarButtonConstraints(backButton)
    leftBarView.insertArrangedSubview(backButton, at: 0)
  }
  
  func addleftBarItems(_ items: UIView...) {
    // Clear previous items
    leftBarView.arrangedSubviews.forEach { (subView) in
      subView.removeFromSuperview()
    }
    
    items.forEach { (item) in
      addBarButtonConstraints(item)
      leftBarView.addArrangedSubview(item)
    }
  }
  
  func addRightBarItems(_ items: UIView...) {
    // Clear previous items
    rightBarView.arrangedSubviews.forEach { (subView) in
      subView.removeFromSuperview()
    }
    
    items.forEach { (item) in
      addBarButtonConstraints(item)
      rightBarView.addArrangedSubview(item)
    }
  }
  
  func setTitle(_ title: String) {
    titleLabel.text = title
  }
}
