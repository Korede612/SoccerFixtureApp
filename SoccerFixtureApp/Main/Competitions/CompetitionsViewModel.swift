//
//  CompetitionsViewModel.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import Combine

class CompetitionsViewModel {
    var matches: [Competition]?
    var competitionsService: GoMoneyCompetitionAPIProtocol = CompetitionsService()
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        fetchCompetitions()
    }
    
    func fetchCompetitions() {
        competitionsService.fetchCompetitionData()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                print(completion)
            } receiveValue: { [weak self] model in
                guard let self else { return }
                print("The result from the network call for competition is: \(model)")
                matches = model
            }
            .store(in: &subscriptions)
        return
    }
}
