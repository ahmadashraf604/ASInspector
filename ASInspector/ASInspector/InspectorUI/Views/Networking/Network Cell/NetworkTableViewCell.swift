//
//  NetworkTableViewCell.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

class NetworkTableViewCell: BaseTableView {
  
  @IBOutlet private weak var statusView: UIView!
  @IBOutlet private weak var urlLabel: UILabel!
  @IBOutlet private weak var statusLabel: UILabel!
  @IBOutlet private weak var methodLabel: UILabel!
  @IBOutlet private weak var durationLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
  func configure(_ data: NetworkRepresentable?) {
    guard let data else {
      return
    }
    statusView.backgroundColor = .red
    statusView.setCircleCorner()
    urlLabel.text = data.url
    statusLabel.text = data.status
    methodLabel.text = data.method
    durationLabel.text = data.duration
    dateLabel.text = data.date
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    statusView.setCircleCorner()
  }
}
