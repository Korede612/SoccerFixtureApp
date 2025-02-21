//
//  PersistLeagueData.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 21/02/2025.
//

import Foundation
import RealmSwift

class PersistLeagueData: Object, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var competitions: List<PersistedCompetition>

    override class func primaryKey() -> String? {
        return "id"
    }
}

class PersistedCompetition: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var area: PersistedArea?
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var plan: String?
    @Persisted var numberOfAvailableSeasons: Int?
    @Persisted var lastUpdated: String?
}

class PersistedArea: Object, Codable {
    @Persisted var id: Int?
    @Persisted var name: String?
    
    convenience init(id: Int?, name: String?) {
        self.init()
        self.id = id
        self.name = name
    }
}
