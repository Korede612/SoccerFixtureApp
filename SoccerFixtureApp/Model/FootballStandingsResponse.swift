//
//  FootballStandingsResponse.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Foundation

// MARK: - Main Response Model
struct FootballStandingsResponse: Codable {
    let filters: Filters?
    let area: TableArea?
    let competition: TableCompetition?
    let season: Season?
    let standings: [Standing]?
}

extension FootballStandingsResponse {
    init(model: FootballStandingsResponseObject?) {
        filters = Filters(model: model?.filters)
        area = TableArea(model: model?.area)
        competition = TableCompetition(model: model?.competition)
        season = Season(model: model?.season)
        standings = model?.standings.map({ Standing(model: $0)})
    }
}

// MARK: - Filters
struct Filters: Codable {
    let season: String?
}

extension Filters {
    init(model: FiltersObject?) {
        season = model?.season
    }
}

// MARK: - Area
struct TableArea: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
}

extension TableArea {
    init(model: TableAreaObject?) {
        id = model?.id
        name = model?.name
        code = model?.code
        flag = model?.flag
    }
}

// MARK: - Competition
struct TableCompetition: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let type: String?
    let emblem: String?
}

extension TableCompetition {
    init(model: TableCompetitionObject?) {
        id = model?.id
        name = model?.name
        code = model?.code
        type = model?.type
        emblem = model?.emblem
    }
}

// MARK: - Season
struct Season: Codable {
    let id: Int?
    let startDate: String?
    let endDate: String?
    let currentMatchday: Int?
    let winner: String? // Nullable field
    let stages: [String]?
}

extension Season {
    init(model: SeasonObject?) {
        id = model?.id
        startDate = model?.startDate
        endDate = model?.endDate
        currentMatchday = model?.currentMatchday
        winner = model?.winner
        stages = model?.stages.map { $0 }
    }
}

// MARK: - Standing
struct Standing: Codable {
    let stage: String?
    let type: String?
    let group: String?
    let table: [TableEntry]?
}

extension Standing {
    init(model: StandingObject) {
        stage = model.stage
        type = model.type
        group = model.group
        table = model.table.map({ TableEntry(model: $0)})
    }
}

// MARK: - Table Entry
struct TableEntry: Codable {
    let position: Int?
    let team: Team?
    let playedGames: Int?
    let form: String?
    let won: Int?
    let draw: Int?
    let lost: Int?
    let points: Int?
    let goalsFor: Int?
    let goalsAgainst: Int?
    let goalDifference: Int?
}

extension TableEntry {
    init(model: TableEntryObject?) {
        position = model?.position
        team = Team(model: model?.team)
        playedGames = model?.playedGames
        form = model?.form
        won = model?.won
        draw = model?.draw
        lost = model?.lost
        points = model?.points
        goalsFor = model?.goalsFor
        goalsAgainst = model?.goalsAgainst
        goalDifference = model?.goalDifference
    }
}

// MARK: - Team
struct Team: Codable, TeamsDataInterface {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let crest: String?
}

extension Team {
    init(model: TeamObject?) {
        id = model?.id
        name = model?.name
        shortName = model?.shortName
        tla = model?.tla
        crest = model?.crest
    }
}
