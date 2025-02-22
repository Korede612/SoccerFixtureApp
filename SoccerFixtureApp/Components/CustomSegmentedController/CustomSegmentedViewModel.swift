//
//  CustomSegmentedViewModel.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Combine
import Foundation

class CustomSegmentedViewModel: NSObject {
    @Published var options: [OptionData] = []
    
    @Published var selectedIndex: Int = 0
    
    init(options: [String]) {
        self.options = options.map { Option(title: $0)}
        super.init()
        self.options[0].isSelected = true
        selectedIndex = 0
    }
    
    func handleSelection(at index: Int) {
        options = options.map { Option(title: $0.title)}
        options[index].isSelected = true
        selectedIndex = index
    }
}
