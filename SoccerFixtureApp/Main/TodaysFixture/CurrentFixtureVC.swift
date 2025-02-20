//
//  CurrentFixtureVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import UIKit

class CurrentFixtureVC: GoMoneyMainVC {
    
    var fixtureViewModel: FixtureViewModel = FixtureViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Today's Fixtures")
    }
}
