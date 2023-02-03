//
//  BaseRootViewController.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

class BaseRootViewController: BaseViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func configureView() {
    addCloseButton()
  }
}

// MARK: - Private view Helpers
private extension BaseRootViewController {
  
  func addCloseButton() {
    let closeButton = uiHelper.getNavigationButton(image: AppImages.closeIcon)
    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    headerView?.addRightBarItems(closeButton)
  }
}

// MARK: - IBAction
private extension BaseRootViewController {
  @IBAction func closeButtonTapped(_ sender: Any) {
    UIManager.shared.dismissUI()
  }
}
