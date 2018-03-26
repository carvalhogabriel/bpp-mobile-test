//
//  DataRequestDelegate.swift
//  bpp-mobile-test
//
//  Created by Gabriel Carvalho Dev Dev on 24/03/18.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation

class DataRequestDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("\(challenge.debugDescription)")
        print("\(String(describing: challenge.error))")
        print("\(String(describing: challenge.failureResponse))")
        print("\(String(describing: challenge.proposedCredential))")
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("Challenge Received")
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
}

extension Data {
    func parseJsonData() -> NSDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: self, options:[]) as? NSDictionary
        } catch {
            print("Failed to parse json from response with error \(error)")
            return nil
        }
    }
    
    func parseJsonArrayData() -> [NSDictionary]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options:[]) as? [NSDictionary]
        } catch {
            print("Failed to parse json from response with error \(error)")
            return nil
        }
    }
}
