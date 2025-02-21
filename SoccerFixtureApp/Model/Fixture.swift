//
//  Fixture.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

struct Fixture: Codable {
    var matches: [Matches]
}

struct Matches: Codable {
    let id: Int
    let utcDate: String
    var status: String?
    var matchday: Int?
    var lastUpdated: String?
    var homeTeam, awayTeam: PlayingTeams
    let score: Score
}

extension Matches {
    init(model match: PersistedMatch) {
        id = match.id
        utcDate = match.utcDate
        status = match.status
        matchday = match.matchday
        lastUpdated = match.lastUpdated
        homeTeam = PlayingTeams(name: match.homeTeam?.name)
        awayTeam = PlayingTeams(name: match.awayTeam?.name)
        score = Score(fullTime: FullTime(homeTeam: match.score?.fullTime?.homeTeam, awayTeam: match.score?.fullTime?.awayTeam))
    }
}

struct PlayingTeams: Codable {
    var name: String?
}

struct Score: Codable {
    let fullTime: FullTime
}

struct FullTime: Codable {
    var homeTeam: Int?
    var awayTeam: Int?
}
