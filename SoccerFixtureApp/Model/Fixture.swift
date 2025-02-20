//
//  Fixture.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

struct Fixture: Codable {
    let matches: [Matches]
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
