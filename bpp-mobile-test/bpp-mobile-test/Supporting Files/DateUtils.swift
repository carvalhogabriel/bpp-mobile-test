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
    
    open func dateFromString(_ date: String?) -> Date? {
        var result: Date?
        if let dateValue = date {
            let dateFormatter = defaultDateFormatter()
            result = dateFormatter.date(from: dateValue)
        } else {
            result = nil
        }
        return result
    }
    
    open func defaultDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }
}
