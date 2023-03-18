//
//  UITableView+Helpers.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 03/02/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

extension UITableView {
  
  // MARK: - Register & Dequeue Cells
  func registerCellNib<T: UITableViewCell>(_ cellClass: T.Type) {
    let bundle = Bundle(for: T.self)
    self.register(
      UINib(
        nibName: String(describing: T.self),
        bundle: bundle),
      forCellReuseIdentifier: String(describing: T.self)
    )
  }
  
  func registerCellClass<T: UITableViewCell>(_ cellClass: T.Type) {
    self.register(
      T.self,
      forCellReuseIdentifier: String(describing: T.self)
    )
  }
  
  func registerHeaderFooterClass<T: UITableViewHeaderFooterView>(_ class: T.Type) {
    self.register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
  }
  
  func dequeue<T: UITableViewHeaderFooterView>(headerFooterAt section: Int) -> T {
    let identifier = String(describing: T.self)
    
    guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
      fatalError("Error in cell")
    }
    
    return view
  }
  
  func dequeue<T: UITableViewCell>(cellForItemAt indexPath: IndexPath) -> T {
    let identifier = String(describing: T.self)
    
    guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
      fatalError("Error in cell")
    }
    
    return cell
  }
  
  // MARK: - Appearance Configurations
  /// Apply default app style
  func applyAppAppearance() {
    self.backgroundColor = .clear
  }
  
  /// Removes the separator of the last cell.
  func removeLastCellSeparator() {
    tableFooterView = UIView(frame: CGRect(origin: .zero,
                                           size: CGSize(width: frame.width, height: 1)))
  }
  
  /// Removes the separator of the first cell.
  func removeFirstCellSeparator() {
    tableHeaderView = UIView(frame: CGRect(origin: .zero,
                                           size: CGSize(width: frame.width, height: 1)))
  }
  
  /// Hides the separator of the first cell.
  func hideFirstCellSeparatorForGroupedTableView() {
    contentInset = UIEdgeInsets(top: -1, left: .zero, bottom: .zero, right: .zero)
  }
  
  /// Change `self.tableFooterView` to an empty view in order to hide the `UITableView`'s
  /// default row placeholders (with separators).
  ///
  /// This intentionally have an absurdingly long method name because we want to be clear that
  /// we are replacing the `tableFooterView` property.
  func applyFooterViewForHidingExtraRowPlaceholders() {
    tableFooterView = UIView(frame: .zero)
  }
  
  /// Used to set and layout `TableViewHeader`
  func setTableViewHeaderView(_ headerView: UIView) {
    tableHeaderView = headerView
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    tableHeaderView = headerView
  }
  
}
