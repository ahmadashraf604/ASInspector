//
//  ViewController.swift
//  ASInspectorDemo
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  private var listData: [ViewData] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    listData = [
      .init(title: "Data - handler", action: dataHandler)
    ]
    tableView.reloadData()
  }
}

// MARK: - Private View Helper
private extension ViewController {
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
  }
}

// MARK: - Handlers
private extension ViewController {
  func dataHandler() {
    let url = URL(string: "https://gorest.co.in/public-api/users?_format=json&access-token=Vy0X23HhPDdgNDNxVocmqv3NIkDTGdK93GfV")!
    
    var urlRequest: URLRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.addValue("abbbbc", forHTTPHeaderField: "xyzzz")
    urlRequest.setValue("gjghj", forHTTPHeaderField: "llnlnoln")
    let json: [String: Any] = ["title": "AB'C",
                               "dict": ["1":"First", "2":"Second"]]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    /**
     // Check application/x-www-form-urlencoded
     
     let myParams = "username=user1&password=12345"
     let postData = myParams.data(using: String.Encoding.ascii, allowLossyConversion: true)
     urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
     */
    urlRequest.httpBody = jsonData
    let session = URLSession.shared
    
    session.dataTask(with: urlRequest) { (data, urlResponse, error) in
      print(error?.localizedDescription ?? "")
    }.resume()
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let index = indexPath.row
    listData[safe: index]?.action?()
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    listData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell()
    let index = indexPath.row
    let cellData = listData[safe: index]
    cell.textLabel?.text = cellData?.title
    cell.selectionStyle = .none
    return cell
  }
}

