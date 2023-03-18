//
//  ViewController.swift
//  ASInspectorDemo
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import UIKit
import ASInspector

class ViewController: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  private var listData: [ViewSectionData] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    listData = [
      .init(title: "Networking", list: [
        .init(title: "Data handler", action: clickedOnDataHandler),
        .init(title: "Data Delegate", action: clickedOnDataDelegate),
        .init(title: "Download handler", action: clickedOnDownloadHandler),
        .init(title: "Download Delegate", action: clickedOnDownloadDelegate),
        .init(title: "Download In background", action: clickedOnBackgroundDownload),
      ]),
      .init(title: "Logger", list: [
        .init(title: "Test LogOneLine", action: LogOneLine),
        .init(title: "Test LogMultiLines", action: LogMultiLines)
      ])
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
    tableView.contentInset = .init(top: 16, left: .zero, bottom: 16, right: .zero)
  }
}

// MARK: - Handlers
private extension ViewController {
  func clickedOnDataHandler() {
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
  
  func clickedOnDataDelegate() {
      let url = URL(string: "https://httpbin.org/get")!
      let configuration = URLSessionConfiguration.ephemeral
      let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
      
      let task = session.dataTask(with: URLRequest(url: url))
      task.resume()
  }
}

// Download task
extension ViewController {
    
    func clickedOnDownloadHandler() {
      let url = URL(string: "https://source.unsplash.com/collection/400620/250x350")!
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
      let task = session.downloadTask(with: url) { (fileUrl, response, error) in
          print("Downloaded file url \(fileUrl?.absoluteString ?? "nil")")
      }
      task.resume()
  }
    
    func clickedOnDownloadDelegate() {
      let url = URL(string: "https://source.unsplash.com/collection/400620/250x350")!
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
      let task = session.downloadTask(with: url)
      task.resume()
  }
    
    func clickedOnBackgroundDownload() {
      let url = URL(string: "http://doanarae.com/doanarae/8880-5k-desktop-wallpaper_23842.jpg")!
      let configuration = URLSessionConfiguration.background(withIdentifier: "com.\(UUID().uuidString)")
      let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
      let task = session.downloadTask(with: url)
      task.resume()
  }
}

// Upload task
extension ViewController {
    
    func clickedOnUploadHandler() {
      
      let url = URL(string: "https://httpbin.org/post")!
      var uploadURLRequest = URLRequest(url: url)
      uploadURLRequest.httpMethod = "POST"
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration)
      
      let uploadDict: [String: String] = [
          "Mercedes": "Lewis Hamilton",
          "Ferrari": "Sebastian Vettel",
          "RedBull": "Daniel Ricciardo"
      ]
      
      // let uploadData = try? JSONEncoder().encode(uploadDict)
      let jsonData = try? JSONSerialization.data(withJSONObject: uploadDict)
      let uploadTask = session.uploadTask(with: uploadURLRequest, from: jsonData) { (receivedData, response, error) in
        print(error?.localizedDescription ?? "")
      }
      uploadTask.resume()
  }
    
    func clickedOnUploadDelegate() {
      
      let url = URL(string: "https://httpbin.org/post")!
      var uploadURLRequest = URLRequest(url: url)
      uploadURLRequest.httpMethod = "POST"
      let configuration = URLSessionConfiguration.default
      let session = URLSession(configuration: configuration)
      
      let uploadDict: [String: String] = [
          "Mercedes": "Lewis Hamilton",
          "Ferrari": "Sebastian Vettel",
          "RedBull": "Daniel Ricciardo"
      ]
      
      let jsonData = try? JSONSerialization.data(withJSONObject: uploadDict)
      uploadURLRequest.httpBody = jsonData
      
      let task = session.dataTask(with: uploadURLRequest)
      task.resume()
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let index = indexPath.row
    let section = indexPath.section
    listData[safe: section]?.list[safe: index]?.action?()
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    listData.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    listData[safe: section]?.list.count ?? .zero
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell()
    let index = indexPath.row
    let section = indexPath.section
    let cellData = listData[safe: section]?.list[safe: index]
    cell.textLabel?.text = cellData?.title
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    listData[safe: section]?.title
  }
}

// MARK: - URLSessionDelegate
extension ViewController: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(#function)
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print(#function)
        completionHandler(.performDefaultHandling, nil)
    }
    
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print(#function)
    }
}

// MARK: - Logging View
extension ViewController {
  func LogOneLine() {
    ASInspector.shared.log("Test Test", "AS")
  }
  
  func LogMultiLines() {
    var string = ""
    for _ in 0...10 {
      string += "\n" + "Tests AS logger"
    }
    ASInspector.shared.log(string)
  }
}
