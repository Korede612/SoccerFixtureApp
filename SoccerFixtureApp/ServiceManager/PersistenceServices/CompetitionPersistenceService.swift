//
//  CompetitionPersistenceService.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 21/02/2025.
//

import Foundation
import RealmSwift

protocol CompetitionPersistenceServiceInterface {
    func addFixture(fixture: PersistLeagueData)
    func removeFixture(fixture: PersistLeagueData)
    func removeAllFixture()
    var leagueData: Results<PersistLeagueData> { get }
}

protocol ConvertToCompetionPesistenceModel {
    var leagueData: LeagueData { get set }
    func convertToLeaguePersistenceModel() -> PersistLeagueData
}

extension ConvertToCompetionPesistenceModel {
    
    func convertToLeaguePersistenceModel() -> PersistLeagueData {
        let convertedLeague = PersistLeagueData()
//        convertedFixture.id = fixture.id
        convertedLeague.competitions = List<PersistedCompetition>()
        _ = leagueData.competitions.map { match in
            let newMatch = convertToCompetitionPersistenceModel(match: match)
            convertedLeague.competitions.append(newMatch)
        }
        return convertedLeague
    }
    
    func convertToCompetitionPersistenceModel(match: Competition) -> PersistedCompetition {
        let newData = PersistedCompetition()
        newData.id = match.id
        newData.area = PersistedArea(id: match.area.id, name: match.area.name)
        newData.code = match.code
        newData.lastUpdated = match.lastUpdated
        newData.name = match.name
        newData.numberOfAvailableSeasons = match.numberOfAvailableSeasons
        newData.plan = match.plan
        return newData
    }
}


class CompetitionPersistenceService: CompetitionPersistenceServiceInterface {
    
    private let realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    var leagueData: Results<PersistLeagueData> {
        return realm.objects(PersistLeagueData.self)
    }
    
    func addFixture(fixture: PersistLeagueData) {
        do {
            try realm.write {
                let savedFixture = realm.objects(PersistLeagueData.self).where { newFixture in
                    newFixture.id == fixture.id
                }
                if savedFixture.isEmpty {
                    self.realm.add(fixture)
                }
                
            }
        } catch let error {
            print("An error of \(error) occured")
        }
        
    }
    
    func removeFixture(fixture: PersistLeagueData) {
        let savedFixture = realm.objects(PersistLeagueData.self).where { newfixture in
            newfixture.id == fixture.id
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
