//
//  GoMoneyMainVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import UIKit

class GoMoneyMainVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate {

    let tableView = UITableView(frame: .zero, style: .plain)
    private var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the TableView
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self // Assign self to handle scroll behavior
        view.addSubview(tableView)
        // Default cell registration
        tableView.backgroundColor = .green
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // Allow child view controllers to configure the table view
    func configureTableView(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func setLeftAlignedTitle(_ title: String) {
            // Create a UILabel for the title
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            titleLabel.textColor = .black
            titleLabel.sizeToFit()

            // Create a container UIView to position the title
            let titleContainer = UIView()
            titleContainer.addSubview(titleLabel)

            // Add constraints to align the label to the left
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor)
            ])

            // Set the container as the navigation item's title view
            navigationItem.titleView = titleContainer
        }

    // UIScrollViewDelegate Method to handle scroll behavior
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y

        // Check scroll direction
        if currentOffset > lastContentOffset {
            // Scrolling downward - hide navigation and tab bar
            setNavigationAndTabBar(hidden: true)
        } else if currentOffset < lastContentOffset && currentOffset <= 100 {
            // Scrolling upward and within threshold - show navigation and tab bar
            setNavigationAndTabBar(hidden: false)
        }

        lastContentOffset = currentOffset
    }

    // Helper to toggle visibility of navigation and tab bars
    func setNavigationAndTabBar(hidden: Bool) {
        self.navigationController?.navigationBar.isHidden = hidden
        tabBarController?.tabBar.isHidden = hidden
    }
}
