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
}

extension GoMoneyNetworking: TargetType {
    
    var path: String {
        switch self {
        case .fetchFixture:
            return "matches"
        case .fetchCompetitions:
            return "competitions"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchFixture, .fetchCompetitions:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchFixture, .fetchCompetitions:
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
