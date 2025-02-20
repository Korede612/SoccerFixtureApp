//
//  NetworkUtil.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Foundation

protocol APITokenProvider {
    var apiToken: String { get }
}

extension APITokenProvider {
    var apiToken: String {
        Bundle.main.object(forInfoDictionaryKey: "APIToken") as? String ?? ""
    }
}
