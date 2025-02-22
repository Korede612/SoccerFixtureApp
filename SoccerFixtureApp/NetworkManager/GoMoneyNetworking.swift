//
//  GoMoneyNetworking.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

enum GoMoneyNetworking {
    case fetchFixture
    case fetchCompetitions
    case leagueInfo(code: String)
}

extension GoMoneyNetworking: TargetType {
    
    var path: String {
        switch self {
        case .fetchFixture:
            return "matches"
        case .fetchCompetitions:
            return "competitions"
        case .leagueInfo(let code):
            return "competitions/\(code)/standings"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchFixture, .fetchCompetitions, .leagueInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchFixture, .fetchCompetitions, .leagueInfo:
            return .getRequest
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "https://api.football-data.org/v4/"
        }
    }
}
