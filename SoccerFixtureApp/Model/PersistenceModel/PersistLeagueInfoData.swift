//
//  PersistLeagueInfoData.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Foundation
import RealmSwift

// MARK: - FootballStandingsResponse
class FootballStandingsResponseObject: Object {
    @Persisted var filters: FiltersObject?
    @Persisted var area: TableAreaObject?
    @Persisted var competition: TableCompetitionObject?
    @Persisted var season: SeasonObject?
    @Persisted var standings: List<StandingObject>

    convenience init(filters: Filters?, area: TableArea?, competition: TableCompetition?, season: Season?, standings: [Standing]?) {
        self.init()
        self.filters = filters != nil ? FiltersObject(filters: filters!) : nil
        self.area = area != nil ? TableAreaObject(area: area!) : nil
        self.competition = competition != nil ? TableCompetitionObject(competition: competition!) : nil
        self.season = season != nil ? SeasonObject(season: season!) : nil
        if let standings = standings {
            self.standings.append(objectsIn: standings.map { StandingObject(standing: $0) })
        }
    }

    static func fromModel(_ model: FootballStandingsResponse?) -> FootballStandingsResponseObject {
        return FootballStandingsResponseObject(
            filters: model?.filters,
            area: model?.area,
            competition: model?.competition,
            season: model?.season,
            standings: model?.standings
        )
    }
}

// MARK: - Filters
class FiltersObject: Object {
    @Persisted var season: String?

    convenience init(filters: Filters) {
        self.init()
        self.season = filters.season
    }
}

// MARK: - TableArea
class TableAreaObject: Object {
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var flag: String?

    convenience init(area: TableArea) {
        self.init()
        self.id = area.id
        self.name = area.name
        self.code = area.code
        self.flag = area.flag
    }
}

// MARK: - TableCompetition
class TableCompetitionObject: Object {
    @Persisted(primaryKey: true) var code: String?
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var type: String?
    @Persisted var emblem: String?

    convenience init(competition: TableCompetition) {
        self.init()
        self.code = competition.code
        self.id = competition.id
        self.name = competition.name
        self.type = competition.type
        self.emblem = competition.emblem
    }
}

// MARK: - Season
class SeasonObject: Object {
    @Persisted var id: Int?
    @Persisted var startDate: String?
    @Persisted var endDate: String?
    @Persisted var currentMatchday: Int?
    @Persisted var winner: String?
    @Persisted var stages: List<String>

    convenience init(season: Season) {
        self.init()
        self.id = season.id
        self.startDate = season.startDate
        self.endDate = season.endDate
        self.currentMatchday = season.currentMatchday
        self.winner = season.winner
        if let stages = season.stages {
            self.stages.append(objectsIn: stages)
        }
    }
}

// MARK: - Standing
class StandingObject: Object {
    @Persisted var stage: String?
    @Persisted var type: String?
    @Persisted var group: String?
    @Persisted var table: List<TableEntryObject>

    convenience init(standing: Standing) {
        self.init()
        self.stage = standing.stage
        self.type = standing.type
        self.group = standing.group
        if let table = standing.table {
            self.table.append(objectsIn: table.map { TableEntryObject(entry: $0) })
        }
    }
}

// MARK: - TableEntry
class TableEntryObject: Object {
    @Persisted var position: Int?
    @Persisted var team: TeamObject?
    @Persisted var playedGames: Int?
    @Persisted var form: String?
    @Persisted var won: Int?
    @Persisted var draw: Int?
    @Persisted var lost: Int?
    @Persisted var points: Int?
    @Persisted var goalsFor: Int?
    @Persisted var goalsAgainst: Int?
    @Persisted var goalDifference: Int?

    convenience init(entry: TableEntry) {
        self.init()
        self.position = entry.position
        self.team = entry.team != nil ? TeamObject(team: entry.team!) : nil
        self.playedGames = entry.playedGames
        self.form = entry.form
        self.won = entry.won
        self.draw = entry.draw
        self.lost = entry.lost
        self.points = entry.points
        self.goalsFor = entry.goalsFor
        self.goalsAgainst = entry.goalsAgainst
        self.goalDifference = entry.goalDifference
    }
}

// MARK: - Team
class TeamObject: Object {
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var shortName: String?
    @Persisted var tla: String?
    @Persisted var crest: String?

    convenience init(team: Team) {
        self.init()
        self.id = team.id
        self.name = team.name
        self.shortName = team.shortName
        self.tla = team.tla
        self.crest = team.crest
    }
}
