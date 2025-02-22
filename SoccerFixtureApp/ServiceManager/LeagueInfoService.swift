//
//  LeagueInfoService.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Foundation
import Combine

class LeagueInfoService: GoMoneyAPI<GoMoneyNetworking>, GoMoneyTablesAPIProtocol {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchCompetitionData(code: String) -> Future<FootballStandingsResponse?, Error> {
        return Future<FootballStandingsResponse?, Error> {[weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            self.fetchData(target: .leagueInfo(code: code), responseClass: FootballStandingsResponse.self)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print("Completion: \(completion)")
                } receiveValue: { result in
                    let standings = result
                    promise(.success(standings))
                }
                .store(in: &self.subscriptions)
        }
    }
    
}
