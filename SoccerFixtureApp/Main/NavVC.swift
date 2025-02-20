//
//  NavVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import UIKit

class NavVC: UINavigationController, UIScrollViewDelegate, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize the large title appearance
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.largeTitleTextAttributes = [
                    .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                    .foregroundColor: UIColor.black
                ]
                appearance.titleTextAttributes = [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                    .foregroundColor: UIColor.gray
                ]
                appearance.backgroundColor = .white

                navigationBar.standardAppearance = appearance
                navigationBar.scrollEdgeAppearance = appearance
    }
    
    // Helper to toggle visibility of navigation and tab bars
    func setNavigationAndTabBar(hidden: Bool) {
        self.navigationController?.navigationBar.isHidden = hidden
        tabBarController?.tabBar.isHidden = hidden
    }
}
