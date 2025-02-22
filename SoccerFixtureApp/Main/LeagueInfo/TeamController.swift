//
//  TeamController.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import Combine
import UIKit

class TeamController: UIViewController {
    
    var viewModel: LeagueInfoViewModel? = nil
    var competition: Competition? = nil
    
    var collecctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collecctionView)
        collecctionView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, paddingLeft: 0, paddingRight: 0)
        
        collecctionView.delegate = viewModel
        collecctionView.dataSource = viewModel
        
        collecctionView.register(TeamCell.self, forCellWithReuseIdentifier: TeamCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBindings()
    }
    
    func setupBindings() {
        viewModel?.$standings.sink { [weak self] standings in
            guard let self else { return }
            collecctionView.reloadData()
        }
        .store(in: &cancellables)
    }
}

extension LeagueInfoViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return standings.first?.table?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell,
              let model = standings.first?.table?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(with: model.team)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.bounds.width ) - CGFloat(8 * 2) - 30) / CGFloat(3), height: 180)
    }
    
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAt section: Int
        ) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    
}
