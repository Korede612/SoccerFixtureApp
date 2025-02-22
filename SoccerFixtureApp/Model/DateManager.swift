//
//  DateManager.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

protocol DateManager {
    func isNewDay(type: NetwokType) -> Bool
    func updateLastFetchDate(type: NetwokType)
}

enum NetwokType {
    case fixtures
    case competition
    case leagueInfo(code: String)
    
    var lastFetchDateKey: String {
        switch self {
        case .competition:
            return "lastFetchDateForCompetition"
        case .fixtures:
            return "lastFetchDateForFixture"
        case .leagueInfo(let code):
            return "lastFetchDateForLeagureInfo\(code)"
        }
    }
}

extension DateManager {
    
    
    func isNewDay(type: NetwokType) -> Bool {
        let currentDate = getCurrentDate()
        let lastFetchDate = UserDefaults.standard.string(forKey: type.lastFetchDateKey)
        
        return lastFetchDate != currentDate
    }
    
    func updateLastFetchDate(type: NetwokType) {
        let currentDate = getCurrentDate()
        UserDefaults.standard.set(currentDate, forKey: type.lastFetchDateKey)
    }
    
    private func getCurrentDate() -> String {
        // Get the current date in YYYY-MM-DD format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
