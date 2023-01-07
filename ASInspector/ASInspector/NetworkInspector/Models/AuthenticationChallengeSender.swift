//
//  AuthenticationChallengeSender.swift
//  ASInspector
//
//  Created by Ahmed Ashraf on 07/01/2023.
//

import Foundation

class AuthenticationChallengeSender: NSObject, URLAuthenticationChallengeSender {
  
  typealias AuthenticationChallengeHandler = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
  
  fileprivate var handler: AuthenticationChallengeHandler
  
  init(handler: @escaping AuthenticationChallengeHandler) {
    self.handler = handler
    super.init()
  }
  
  func use(_ credential: URLCredential, for challenge: URLAuthenticationChallenge) {
    handler(URLSession.AuthChallengeDisposition.useCredential, credential)
  }
  
  func continueWithoutCredential(for challenge: URLAuthenticationChallenge) {
    handler(URLSession.AuthChallengeDisposition.useCredential, nil)
  }
  
  func cancel(_ challenge: URLAuthenticationChallenge) {
    handler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
  }
  
  func performDefaultHandling(for challenge: URLAuthenticationChallenge) {
    handler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
  }
  
  func rejectProtectionSpaceAndContinue(with challenge: URLAuthenticationChallenge) {
    handler(URLSession.AuthChallengeDisposition.rejectProtectionSpace, nil)
  }
  
}
