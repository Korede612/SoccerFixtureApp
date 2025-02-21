//
//  Extension+String.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 21/02/2025.
//

import Foundation

protocol DateFormatterProtocol {
    var inputFormatter: DateFormatter { get }
    func getDay(dateString: String) -> String
    func getTime(dateString: String) -> String
}

extension DateFormatterProtocol {
    var inputFormatter: DateFormatter {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        return inputFormatter
    }
    
    func getDay(dateString: String) -> String {
        
        if let date = inputFormatter.date(from: dateString) {
            
            // 3. Extract the day
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE" // Full day name
            let day = dayFormatter.string(from: date)
            return day
            
        }
        return ""
    }
    
    func getTime(dateString: String) -> String {
        
        if let date = inputFormatter.date(from: dateString) {
            
            // 3. Extract the day
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm" // Time in 12-hour format with AM/PM
            let time = timeFormatter.string(from: date)
            return time
            
        }
        return ""
    }
}
extension String: DateFormatterProtocol {
    func localized(comment: String? = nil) -> String {
        NSLocalizedString(self, comment: comment ?? "")
    }
    
    func getTime() -> String {
        getTime(dateString: self)
    }
    
}
