//
//  LoginApi.swift
//  bpp-mobile-test
//
//  Created by Gabriel Carvalho Dev on 23/03/18.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation
import UIKit

public class LoginApi {
    
    open static let sharedInstance = LoginApi()
    
    lazy var dataSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 25
        config.timeoutIntervalForResource = ApiUtils.ApiConstants.TIME_OUT_INTERVAL_FOR_RESOURCE
        
        var delegate = DataRequestDelegate()
        
        var session = URLSession(configuration: config, delegate: delegate as URLSessionDelegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    //Método para autenticar o usuario
    open func authenticateUser(_ login: String?, _ password: String?, callback: @escaping (_ error: NSError?) -> Void) {
        guard login != nil else {
            print("Failed to load userName")
            return
        }
        
        guard password != nil else {
            print("Failed to load userPassword")
            return
        }
        
        let stringBody = "email=\(login!)&password=\(encodePassword(password!))"
        
        var request = ApiUtils.sharedInstance.webserviceRequestBuilder("/login")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        request.httpBody = stringBody.data(using: String.Encoding.utf8)

        let dataTask = dataSession.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    guard let responseData = data ,let jsonResult = responseData.parseJsonData() else {
                        print("Failed to load or parse json data")
                        return
                    }
                    if let successCode = jsonResult["code"] as? String, successCode == "200"{
                        return callback(nil)
                    } else {
                        return callback(NSError(domain: "bpp-test", code: 300, userInfo: ["Usuario Invalido": "300"]))
                    }
                default:
                    print("Unexpected status code \(httpResponse.statusCode)")
                    return callback(NSError(domain: "bpp-test", code: httpResponse.statusCode, userInfo: ["Generic Error": "0"]))
                }
            }
        })
        dataTask.resume()
        }
    
    private func encodePassword(_ password: String) -> String {
        let passUTF8 = password.data(using: String.Encoding.utf8)
        let passwordBase64 = passUTF8?.base64EncodedString()
        return passwordBase64!
    }
}
