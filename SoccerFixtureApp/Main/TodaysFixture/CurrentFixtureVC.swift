//
//  CurrentFixtureVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Combine
import UIKit

class CurrentFixtureVC: GoMoneyMainVC {
    
    var viewModel: FixtureViewModel = FixtureViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Today's Fixtures")
        setupBindings()
        registerCell(cell: FixtureCell.self, identifier: FixtureCell.reseuseIdentifier)
        configureTableView(dataSource: self)
        viewModel.fetchFixture()
    }
    
    func setupBindings() {
        viewModel.$matches.receive(on: RunLoop.main).sink { [weak self] matches in
            guard let self else { return }
            tableView.reloadData()
            print("Here are the matches: \(matches)")
        }
        .store(in: &cancellables)
    }
}

extension CurrentFixtureVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FixtureCell.reseuseIdentifier, for: indexPath) as? FixtureCell else { return UITableViewCell() }
        cell.configure(with: viewModel.matches[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
}
