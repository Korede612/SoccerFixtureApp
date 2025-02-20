//
//  CompetitionsVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import UIKit

class CompetitionsVC: GoMoneyMainVC {
    
    var viewModel: CompetitionsViewModel = CompetitionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Competitions")
    }
}
