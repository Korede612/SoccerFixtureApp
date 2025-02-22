//
//  CompetitionsService.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import Combine

class CompetitionsService: GoMoneyAPI<GoMoneyNetworking>, GoMoneyCompetitionAPIProtocol {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchCompetitionData() -> Future<[Competition], Error> {
        return Future<[Competition], Error> {[weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            self.fetchData(target: .fetchCompetitions, responseClass: LeagueData.self)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print("Completion: \(completion)")
                } receiveValue: { result in
                    let competitions = result.competitions
                    promise(.success(competitions))
                }
                .store(in: &self.subscriptions)
        }
    }
    
}

