//
//  TableController.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//


import Combine
import UIKit

class TableController: UIViewController {
    
    var competition: Competition? = nil
    let tableView = UITableView(frame: .zero, style: .plain)
    var viewModel: LeagueInfoViewModel?
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.register(StandingCell.self, forCellReuseIdentifier: StandingCell.reseuseIdentifier)
        
        tableView.delegate = viewModel // Assign self to handle scroll behavior
        tableView.dataSource = viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBindings()
    }
    
    func setupBindings() {
        viewModel?.$standings.sink { [weak self] standings in
            guard let self else { return }
            tableView.reloadData()
        }
        .store(in: &cancellables)
    }
}

extension LeagueInfoViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.first?.table?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StandingCell.reseuseIdentifier, for: indexPath) as? StandingCell,
              let model = standings.first?.table else {
            let cell = UITableViewCell()
            cell.backgroundColor = .purple
            return cell
        }
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
