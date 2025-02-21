//
//  CompetitionsViewModel.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import Combine

class CompetitionsViewModel {
    
    var leagueData: LeagueData = LeagueData(competitions: [])
    @Published var competition: [Competition] = []
    var competitionsService: GoMoneyCompetitionAPIProtocol = CompetitionsService()
    var competitionPersistenceService: CompetitionPersistenceServiceInterface = CompetitionPersistenceService()
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchCompetitions() {
        let leagueData = competitionPersistenceService.leagueData
        
        if isNewDay() || leagueData.isEmpty {
            competitionsService.fetchCompetitionData()
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    print(completion)
                } receiveValue: { [weak self] model in
                    guard let self else { return }
                    self.leagueData.competitions = model
                    competition = model
                    competitionPersistenceService.addFixture(fixture: convertToLeaguePersistenceModel())
                }
                .store(in: &subscriptions)
        } else {
            leagueData.first?.competitions.forEach { savedCompetition in
                let competition = Competition(model: savedCompetition)
                self.competition.append(competition)
            }
        }
    }
}

extension CompetitionsViewModel: DateManager { }
extension CompetitionsViewModel: ConvertToCompetionPesistenceModel { }
