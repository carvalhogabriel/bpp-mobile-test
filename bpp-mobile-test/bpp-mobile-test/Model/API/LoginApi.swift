//
//  LoginApi.swift
//  bpp-mobile-test
//
//  Created by School Picture Dev on 23/03/18.
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
        
//        var delegate = DataRequestDelegate()
        
        var session = URLSession(configuration: config, delegate: delegate as URLSessionDelegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
}
