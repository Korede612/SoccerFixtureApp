//
//  LeagueInfoViewModel.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Foundation
import Combine

class LeagueInfoViewModel: NSObject {
    
    var leagueInfoData: FootballStandingsResponse?
    
    @Published var standings: [Standing] = []
    var leagueInfoService: GoMoneyTablesAPIProtocol = LeagueInfoService()
    var leagueInfoPersistenceService: LeagueInfoPersistenceServiceInterface = LeagueInfoPersistenceService()
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func fetchTeamStandings(code: String) {
        let savedLeagueInfo = leagueInfoPersistenceService.fetchFootballStandingsResponse(byCode: code)
        if isNewDay(type: .leagueInfo(code: code)) || savedLeagueInfo == nil {
            leagueInfoService.fetchCompetitionData(code: code)
                .receive(on: RunLoop.main)
                .sink { completion in
                    print(completion)
                } receiveValue: { [weak self] model in
                    guard let self else { return }
                    leagueInfoData = model
                    self.standings = model?.standings ?? []
                    let saveLeagueInfo = FootballStandingsResponseObject.fromModel(leagueInfoData)
                    leagueInfoPersistenceService.addFixture(fixture: saveLeagueInfo)
                    updateLastFetchDate(type: .leagueInfo(code: code))
                }
                .store(in: &subscriptions)
        } else {
            let savedFootballStanding = FootballStandingsResponse(model: savedLeagueInfo)
            standings = savedFootballStanding.standings ?? []
        }
    }
}

extension LeagueInfoViewModel: DateManager { }
extension LeagueInfoViewModel: ConvertToLeagueInfoPesistenceModel { }
