//
//  BaseNavigationController.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        self.interactivePopGestureRecognizer?.delegate = nil
    }
}
