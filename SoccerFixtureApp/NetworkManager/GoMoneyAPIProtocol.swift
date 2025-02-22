//
//  GoMoneyAPIProtocol.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Combine

protocol GoMoneyFixtureAPIProtocol {
    func fetchFixtureData() -> Future<[Matches], Error>
}

protocol GoMoneyCompetitionAPIProtocol {
    func fetchCompetitionData() -> Future<[Competition], Error>
}

protocol GoMoneyTablesAPIProtocol {
    func fetchCompetitionData(code: String) -> Future<FootballStandingsResponse?, Error>
}
