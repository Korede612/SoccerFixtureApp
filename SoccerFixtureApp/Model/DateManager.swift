//
//  DateManager.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

protocol DateManager {
    var lastFetchDateKey: String { get }
    func isNewDay() -> Bool
    func updateLastFetchDate()
}

extension DateManager {
    var lastFetchDateKey: String {
        return "lastFetchDate"
    }
    
    func isNewDay() -> Bool {
        let currentDate = getCurrentDate()
        let lastFetchDate = UserDefaults.standard.string(forKey: lastFetchDateKey)
        
        return lastFetchDate != currentDate
    }
    
    func updateLastFetchDate() {
        let currentDate = getCurrentDate()
        UserDefaults.standard.set(currentDate, forKey: lastFetchDateKey)
    }
    
    private func getCurrentDate() -> String {
        // Get the current date in YYYY-MM-DD format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
