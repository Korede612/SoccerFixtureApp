//
//  FixtureViewModel.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import Combine

class FixtureViewModel {
    
    var fixture: Fixture = Fixture(matches: [])
    @Published var matches: [Matches] = []
    var fixtureService: GoMoneyFixtureAPIProtocol = FixtureService()
    var fixturePersistenceService: FixturePersistenceServiceInterface = FixturePersistenceService()
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchFixture() {
        let savedFixture = fixturePersistenceService.allFixture
        
        if isNewDay() || savedFixture.isEmpty {
            fixtureService.fetchFixtureData()
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    print(completion)
                } receiveValue: { [weak self] fixture in
                    guard let self else { return }
                    self.fixture.matches = fixture
                    matches = fixture
                    let convertFixture = convertToFixturePersistenceModel()
                    fixturePersistenceService.addFixture(fixture: convertFixture)
                }
                .store(in: &subscriptions)
        } else {
            savedFixture.first?.matches.forEach { fixtureSaved in
                let match = Matches(model: fixtureSaved)
                matches.append(match)
            }
        }
    }
}

extension FixtureViewModel: DateManager { }
extension FixtureViewModel: ConvertToFixturePesistenceModel { }
