//
//  GoMoneyMainVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Combine
import UIKit

class GoMoneyMainVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    private var lastContentOffset: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    private let scrollPublisher = PassthroughSubject<CGFloat, Never>() // To track scroll offsets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the TableView
        //        tableView.frame = view.bounds
        
        tableView.delegate = self // Assign self to handle scroll behavior
        view.addSubview(tableView)
        tableView.pin(to: view)
        // Default cell registration
        setupBindings()
    }
    
    // Allow child view controllers to configure the table view
    func configureTableView(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }
    
    func registerCell(cell: AnyClass, identifier: String) {
        tableView.register(cell, forCellReuseIdentifier: identifier)
    }
    
    private func setupBindings() {
        // Listen to scroll position changes
        scrollPublisher
            .sink { [weak self] offsetY in
                guard let self = self else { return }
                if offsetY > 20 {
                    setNavigationAndTabBar(hidden: true)
                } else if offsetY <= 0 {
                    setNavigationAndTabBar(hidden: false)
                }
            }
            .store(in: &cancellables)
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
        titleLabel.anchor(leading: titleContainer.leadingAnchor)
        titleLabel.centerAnchor(axis: .vertical, on: titleContainer)
        
        // Set the container as the navigation item's title view
        navigationItem.titleView = titleContainer
    }
    
    // MARK: - TableView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        scrollPublisher.send(offsetY) // Publish the current scroll offset
    }
    
    // Helper to toggle visibility of navigation and tab bars
    func setNavigationAndTabBar(hidden: Bool) {
        //        self.navigationController?.navigationBar.isHidden = hidden
        self.navigationController?.setNavigationBarHidden(hidden, animated: true)
        tabBarController?.tabBar.isHidden = hidden
    }
}
