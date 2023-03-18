//
//  LogTableViewCell.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {
  @IBOutlet private weak var logLabel: UILabel!
  
  func configure(_ logData: LogData?) {
    logLabel.numberOfLines = 8
    logLabel.text = logData?.description
  }
}
