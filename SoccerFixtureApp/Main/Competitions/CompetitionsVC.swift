//
//  CompetitionsVC.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 20/02/2025.
//

import Combine
import UIKit

class CompetitionsVC: GoMoneyMainVC {
    
    var viewModel: CompetitionsViewModel = CompetitionsViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLeftAlignedTitle("Competitions")
        setupBindings()
        registerCell(cell: CompetitionCell.self, identifier: CompetitionCell.reseuseIdentifier)
        configureTableView(dataSource: self)
        viewModel.fetchCompetitions()
    }
    
    func setupBindings() {
        viewModel.$competition.receive(on: RunLoop.main).sink { [weak self] competition in
            guard let self else { return }
            tableView.reloadData()
        }
        .store(in: &cancellables)
    }
}

extension CompetitionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.competition.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompetitionCell.reseuseIdentifier, for: indexPath) as? CompetitionCell else { return UITableViewCell() }
        cell.competitionName = viewModel.competition[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destinationVC = LeagueInfoVC()
        let title = viewModel.competition[indexPath.row].name ?? ""
        destinationVC.title = title
        destinationVC.competition = viewModel.competition[indexPath.row]
        setNavigationAndTabBar(hidden: true)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
