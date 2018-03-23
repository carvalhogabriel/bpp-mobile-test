//
//  ApiUtils.swift
//  bpp-mobile-test
//
//  Created by School Picture Dev on 23/03/18.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation

public class ApiUtils {
    
    public struct ApiConstants {
        #if DEBUG
        static let API_URL = "http://test-mobile.dev-bpp.com.br"
        #else
        static let API_URL = "http://test-mobile.dev-bpp.com.br"
        #endif
        
        static let TIME_OUT_INTERVAL_FOR_RESOURCE: TimeInterval = 300
    }
}
