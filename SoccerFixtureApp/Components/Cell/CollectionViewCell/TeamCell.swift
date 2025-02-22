//
//  TeamCell.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import UIKit
import Kingfisher

protocol TeamsDataInterface {
    var name: String? { get }
    var crest: String? { get }
}
class TeamCell: UICollectionViewCell {
    
    static let identifier: String = "TeamCell"
    
    var titleLabel: UILabel = UILabel.headerTextLabel(fontSize: 12)
    var teamImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        setupShadow()
    }
    
    func configureViews() {
        contentView.addSubview(teamImageView)
        contentView.addSubview(titleLabel)
        teamImageView.anchor(
            top: contentView.topAnchor,
            paddingTop: 20,
            width: 80,
            height: 80
        )
        teamImageView.centerAnchor(axis: .horizontal, on: contentView)
        titleLabel.anchor(
            top: teamImageView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            leading: contentView.leadingAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            paddingRight: 10
        )
        titleLabel.textAlignment = .center
    }
    
    func configure(with teamData: TeamsDataInterface?) {
        titleLabel.text = teamData?.name
        teamImageView.kf.setImage(with: URL(string: teamData?.crest ?? ""))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShadow() {
            layer.cornerRadius = 10
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 2, height: 2)
            layer.shadowRadius = 4
            layer.masksToBounds = false
            backgroundColor = .white
        }
}
