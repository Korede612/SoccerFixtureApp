//
//  Competitions.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

struct LeagueData: Codable{
    var competitions: [Competition]
}

struct Competition: Codable {
    let id: Int
    let area: Area
    var name: String?
    var code: String?
    var plan: String?
    var numberOfAvailableSeasons: Int?
    var lastUpdated: String?
}

extension Competition {
    init(model competition: PersistedCompetition) {
        id = competition.id
        area = Area(id: competition.area?.id, name: competition.area?.name)
        name = competition.name
        code = competition.code
        plan = competition.plan
        numberOfAvailableSeasons = competition.numberOfAvailableSeasons
        lastUpdated = competition.lastUpdated
    }
}

struct Area: Codable {
    let id: Int?
    var name: String?
}

struct CurrentSeason: Codable {
    let id: Int
    var startDate, endDate: String?
    var currentMatchday: Int?
}
