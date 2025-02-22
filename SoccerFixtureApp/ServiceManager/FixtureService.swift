//
//  FixtureService.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import Combine

class FixtureService: GoMoneyAPI<GoMoneyNetworking>, GoMoneyFixtureAPIProtocol {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchFixtureData() -> Future<[Matches], Error> {
        return Future<[Matches], Error> {[weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            self.fetchData(target: .fetchFixture, responseClass: Fixture.self)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print("Completion: \(completion)")
                } receiveValue: { result in
                    let fixtures = result.matches
                    promise(.success(fixtures))
                }
                .store(in: &self.subscriptions)
        }
    }
    
}
