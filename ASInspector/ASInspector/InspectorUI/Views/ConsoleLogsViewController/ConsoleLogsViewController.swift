//
//  ConsoleLogsViewController.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 18/03/2023.
//  Copyright © 2023 Inspector. All rights reserved.
//

import UIKit

class ConsoleLogsViewController: BaseRootViewController {
  // MARK: - IBOutlet
  @IBOutlet private weak var tableView: UITableView!
  
  // MARK: - Properties
  private let loggerManager = LoggerManager.shared
  private var logs: [LogData] = .empty
  
  // MARK: - Init
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: Bundle.current)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    headerView?.setTitle("User Logs")
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadData()
  }
}

// MARK: - Private View Helper
private extension ConsoleLogsViewController {
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    tableView.registerCellNib(LogTableViewCell.self)
  }
}

// MARK: - Private Helpers
extension ConsoleLogsViewController {
  var logsCount: Int {
    logs.count
  }
  
  func getLogData(at index: Int) -> LogData? {
    let cellData = logs[safe: index]
    return cellData
  }
  
  func loadData() {
    logs = loggerManager.fetchAllLogs()
    tableView.reloadData()
  }
}

// MARK: - UITableViewDelegate
extension ConsoleLogsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let index = indexPath.row
//    print(index)
  }
}

// MARK: - UITableViewDataSource
extension ConsoleLogsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    logsCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: LogTableViewCell = tableView.dequeue(cellForItemAt: indexPath)
    let index = indexPath.row
    let cellData = getLogData(at: index)
    cell.configure(cellData)
    return cell
  }
}
