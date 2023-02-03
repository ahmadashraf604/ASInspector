//
//  BaseTableViewCell.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

class BaseTableView: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
  }

}
