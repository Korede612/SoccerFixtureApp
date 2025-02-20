//
//  FixtureViewModel.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import Combine

class FixtureViewModel {
    var fixture: Fixture?
    var fixtureService: GoMoneyFixtureAPIProtocol = FixtureService()
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        fetchFixture()
    }
    
    func fetchFixture() {
        fixtureService.fetchFixtureData()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                print(completion)
            } receiveValue: { [weak self] model in
                print("The result from the network call is: \(model)")
            }
            .store(in: &subscriptions)
        return
    }
}
