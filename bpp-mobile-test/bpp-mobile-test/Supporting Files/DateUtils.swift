//
//  DateUtils.swift
//  bpp-mobile-test
//
//  Created by Gabriel Carvalho on 24/03/2018.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import Foundation

open class DateUtils {
    
    open static let sharedInstance = DateUtils()
    
    open func dateBR(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    open func dateToLocalDateStringBR(_ date: Date, timezone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        if let tz = timezone {
            dateFormatter.timeZone = tz
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
        
    }
    
}
