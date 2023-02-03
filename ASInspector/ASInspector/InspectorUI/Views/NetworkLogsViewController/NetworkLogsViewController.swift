//
//  NetworkLogsViewController.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 08/01/2023.
//

import UIKit

class NetworkLogsViewController: BaseRootViewController {
  @IBOutlet private weak var tableView: UITableView!
  
  private let networkManager = NetworkManager.shared
  private var logs: [NetworkRepresentable] = .empty
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: Bundle.current)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    headerView?.setTitle("Network Logs")
    configureTableView()
    loadData()
  }
}

// MARK: - Private View Helper
private extension NetworkLogsViewController {
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    tableView.registerCellNib(NetworkTableViewCell.self)
  }
}

// MARK: - Private Helpers
extension NetworkLogsViewController {
  var logsCount: Int {
    logs.count
  }
  
  func getLogData(at index: Int) -> NetworkRepresentable? {
    let cellData = logs[safe: index]
    return cellData
  }
  
  func loadData() {
    logs = networkManager.logs
    tableView.reloadData()
  }
}

// MARK: - UITableViewDelegate
extension NetworkLogsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    90
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let index = indexPath.row
    print(index)
  }
}

// MARK: - UITableViewDataSource
extension NetworkLogsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    logsCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: NetworkTableViewCell = tableView.dequeue(cellForItemAt: indexPath)
    let index = indexPath.row
    let cellData = getLogData(at: index)
    cell.configure(cellData)
    return UITableViewCell()
  }
}
