//
//  PersistFixture.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation
import RealmSwift

class PersistedFixture: Object, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var count: Int = 0
    @Persisted var matches: List<PersistedMatch>

    override class func primaryKey() -> String? {
        return "id"
    }
}

class PersistedMatch: Object, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var utcDate: String = ""
    @Persisted var status: String?
    @Persisted var matchday: Int?
    @Persisted var lastUpdated: String?
    @Persisted var homeTeam: PersistedPlayingTeam?
    @Persisted var awayTeam: PersistedPlayingTeam?
    @Persisted var score: PersistedScore?
}

class PersistedPlayingTeam: Object, Codable {
    @Persisted var name: String?
    
    convenience init(name: String?) {
        self.init()
        self.name = name
    }
}

class PersistedScore: Object, Codable {
    @Persisted var fullTime: PersistedFullTime?
    
    // Custom initializer
    convenience init(fullTime: PersistedFullTime?) {
        self.init()
        self.fullTime = fullTime
    }
}

class PersistedFullTime: Object, Codable {
    @Persisted var homeTeam: Int?
    @Persisted var awayTeam: Int?
    
    // Custom initializer
        convenience init(homeTeam: Int?, awayTeam: Int?) {
            self.init() // Call Realm's default initializer
            self.homeTeam = homeTeam
            self.awayTeam = awayTeam
        }
}
