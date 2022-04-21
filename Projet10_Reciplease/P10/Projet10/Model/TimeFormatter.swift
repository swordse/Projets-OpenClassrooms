//
//  TimeFormatter.swift
//  Projet10
//
//  Created by Raphaël Goupille on 14/11/2021.
//

import Foundation

class TimeFormatter {
    // func to format the preparation time
    static func minutesToHours(minutes: Int) -> String {
        
        var timeToDisplay = ""
        let hour = minutes/60
        let minute = minutes % 60
        
        if hour == 0 && minute == 0 {
            timeToDisplay = " ~ "
        }
        if hour == 0 && minute > 0 {
            timeToDisplay = "\(minute)mn"
        }
        if hour > 0 && minute == 0 {
            timeToDisplay = "\(hour)h"
        }
        if hour > 0 && minute > 0 {
            timeToDisplay = "\(hour)h \(minute)mn"
        }
        
        return timeToDisplay
    }
    
}
