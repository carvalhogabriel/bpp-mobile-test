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
    
    open func authenticateUser(_ login: String?, _ password: String?) {
        guard login != nil else {
            print("Failed to load userName")
            return
        }
        
        guard password != nil else {
            print("Failed to load userPassword")
            return
        }
        let passUTF8 = password?.data(using: String.Encoding.utf8)
        
        let passwordBase64 = passUTF8?.base64EncodedString()
        print(passwordBase64!)
        
        var request = ApiUtils.sharedInstance.webserviceRequestBuilder("/login?email=\(String(describing: login!))&password=\(String(describing: passwordBase64!))")
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        let dataTask = dataSession.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    guard let responseData = data ,let jsonResult = responseData.parseJsonData() else {
                        print("error")
//                        callback(ErrorFactory.sharedInstance.buildError(.apiGenericError))
                        return
                    }
                    print(jsonResult)
                    print("200")
                    break;
                default:
                    print("Unexpected status code \(httpResponse.statusCode)")
                }
            }
        })
        dataTask.resume()
        }
}
