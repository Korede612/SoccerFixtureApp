//
//  LeagueInfoPersistenceService.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Foundation
import RealmSwift

protocol LeagueInfoPersistenceServiceInterface {
    func addFixture(fixture: FootballStandingsResponseObject)
    func removeFixture(fixture: FootballStandingsResponseObject)
    func removeAllFixture()
    func fetchFootballStandingsResponse(byCode code: String) -> FootballStandingsResponseObject?
    var leagueData: Results<FootballStandingsResponseObject> { get }
}

protocol ConvertToLeagueInfoPesistenceModel {
    var leagueInfoData: FootballStandingsResponse? { get set }
    func convertToLeaguePersistenceModel() -> FootballStandingsResponseObject?
}

extension ConvertToLeagueInfoPesistenceModel {
    
    func convertToLeaguePersistenceModel() -> FootballStandingsResponseObject? {
        guard let leagueInfoData else { return nil }
        return FootballStandingsResponseObject.fromModel(leagueInfoData)
    }
}


class LeagueInfoPersistenceService: LeagueInfoPersistenceServiceInterface {
    
    private let realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    var leagueData: Results<FootballStandingsResponseObject> {
        return realm.objects(FootballStandingsResponseObject.self)
    }
    
    func addFixture(fixture: FootballStandingsResponseObject) {
        do {
            try realm.write {
                let savedFixture = realm.objects(FootballStandingsResponseObject.self).where { newFixture in
                    newFixture.competition.code == fixture.competition?.code
                }
                if savedFixture.isEmpty {
                    self.realm.add(fixture)
                }
                
            }
        } catch let error {
            print("An error of \(error) occured")
        }
        
    }
    
    func fetchFootballStandingsResponse(byCode code: String) -> FootballStandingsResponseObject? {
        let realm = try! Realm()
        return realm.objects(FootballStandingsResponseObject.self)
            .filter("competition.code == %@", code)
            .first
    }

    
    func removeFixture(fixture: FootballStandingsResponseObject) {
        let savedFixture = realm.objects(FootballStandingsResponseObject.self).where { newfixture in
            newfixture.competition.code == fixture.competition?.code
        }
        do {
            try realm.write {
                self.realm.delete(fixture)
            }
        } catch (let error) {
            print("An error of \(error) occured")
        }
    }
    
    func removeAllFixture() {
        do {
            try realm.write {
                self.realm.delete(leagueData)
            }
        } catch (let error) {
            print("An error of \(error) occured")
        }
    }
    
}
