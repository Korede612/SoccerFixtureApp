//
//  PersistenceService.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import RealmSwift

protocol FixturePersistenceServiceInterface {
    func addFixture(fixture: PersistedFixture)
    func removeFixture(fixture: PersistedFixture)
    func removeAllFixture()
    var allFixture: Results<PersistedFixture> { get }
}

protocol ConvertToFixturePesistenceModel {
    var fixture: Fixture { get set }
    func convertToFixturePersistenceModel() -> PersistedFixture
}

extension ConvertToFixturePesistenceModel {
    
    func convertToFixturePersistenceModel() -> PersistedFixture {
        let convertedFixture = PersistedFixture()
        convertedFixture.matches = List<PersistedMatch>()
        _ = fixture.matches.map { match in
            let newMatch = convertToMatchPersistenceModel(match: match)
            convertedFixture.matches.append(newMatch)
        }
        return convertedFixture
    }
    
    func convertToMatchPersistenceModel(match: Matches) -> PersistedMatch {
        let newMatch = PersistedMatch()
        newMatch.id = match.id
        newMatch.awayTeam = PersistedPlayingTeam(name: match.awayTeam.name ?? "") //match.awayTeam.name
        newMatch.homeTeam = PersistedPlayingTeam(name: match.homeTeam.name ?? "")
        newMatch.lastUpdated = match.lastUpdated
        let fullTime = PersistedFullTime(homeTeam: match.score.fullTime.homeTeam, awayTeam: match.score.fullTime.awayTeam)
        newMatch.score = PersistedScore(fullTime: fullTime)
        newMatch.score?.fullTime?.homeTeam = match.score.fullTime.homeTeam
        newMatch.status = match.status
        newMatch.utcDate = match.utcDate
        newMatch.matchday = match.matchday
        return newMatch
    }
}


class FixturePersistenceService: FixturePersistenceServiceInterface {
    
    private let realm: Realm!
    
    init() {
        realm = try! Realm()
    }
    
    var allFixture: Results<PersistedFixture> {
        return realm.objects(PersistedFixture.self)
    }
    
    func addFixture(fixture: PersistedFixture) {
        do {
            try realm.write {
                let savedFixture = realm.objects(PersistedFixture.self).where { newFixture in
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
    
    func removeFixture(fixture: PersistedFixture) {
        let savedFixture = realm.objects(PersistedFixture.self).where { newfixture in
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
                self.realm.delete(allFixture)
            }
        } catch (let error) {
            print("An error of \(error) occured")
        }
    }
    
}
