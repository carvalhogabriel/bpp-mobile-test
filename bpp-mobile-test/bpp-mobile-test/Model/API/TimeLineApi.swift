//
//  TimeLineApi.swift
//  bpp-mobile-test
//
//  Created by School Picture on 24/03/2018.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation
import UIKit

public class TimeLineApi {
    
    open static let sharedInstance = TimeLineApi()
    
    lazy var dataSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 25
        config.timeoutIntervalForResource = ApiUtils.ApiConstants.TIME_OUT_INTERVAL_FOR_RESOURCE
        
        var delegate = DataRequestDelegate()
        
        var session = URLSession(configuration: config, delegate: delegate as URLSessionDelegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    open func fetchTimeLine(callback: @escaping(_ timeLines: [NSDictionary]?, _ error: Error?) -> Void) {
        var request = ApiUtils.sharedInstance.webserviceRequestBuilder("/invoice")
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let dataTask = dataSession.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    guard let responseData = data, let jsonResult = responseData.parseJsonArrayData() else {
                        print("Failed to load or parse json array data")
                        return
                    }
                    callback(jsonResult, nil)
                default:
                    print("Unexpected status code \(httpResponse.statusCode)")
                    callback(nil, error)
                    
                }
            }
        }
        dataTask.resume()
    }
}
