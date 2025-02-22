//
//  StandingCell.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import UIKit
import Kingfisher

class StandingCell: UITableViewCell {
    
    static let reseuseIdentifier = "StandingCell"
    
    var mainStackView: UIStackView = UIStackView()
    var positionStackView: UIStackView = UIStackView()
    var scoreStackView: UIStackView = UIStackView()
    
    var positionLabel: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var teamIcon: UIImageView = UIImageView()
    
    var teamLabel: UILabel = UILabel.headerTextLabel(fontSize: 12)
    
    var numberOfGamePlayedLabel: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var goalDifferenceLabel: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var gamePointsLabel: UILabel = UILabel.headerTextLabel(fontSize: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
//        backgroundColor = .gray
        
        setupUI()
    }
    
    func setupUI() {
        layoutMainStackView()
        layoutPositionStackView()
        layoutTeamScoreStackView()
        teamLabel.anchor(width: self.bounds.width * 0.6)
    }
    
    func layoutMainStackView() {
        mainStackView.anchor(
            top: topAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            leading: leadingAnchor,
            paddingTop: 16,
            paddingLeft: 16,
            paddingBottom: 16,
            paddingRight: 16
        )
        
        [
            positionStackView,
            teamLabel,
            scoreStackView
        ]
            .forEach { mainStackView.addArrangedSubview($0) }
        mainStackView.axis = .horizontal
        mainStackView.spacing = 8
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
    }
    
    func layoutTeamScoreStackView() {
        [
            numberOfGamePlayedLabel,
            goalDifferenceLabel,
            gamePointsLabel
        ].forEach { label in
            scoreStackView.addArrangedSubview(label)
        }
        scoreStackView.axis =  .horizontal
        scoreStackView.spacing = 4
        scoreStackView.distribution = .fillEqually
    }
    
    func layoutPositionStackView() {
        positionStackView.axis = .horizontal
        positionStackView.spacing = 6
        [positionLabel, teamIcon].forEach { positionStackView.addArrangedSubview($0) }
        teamIcon.anchor(width: 30, height: 30)
        positionStackView.anchor(width: self.bounds.width * 0.2)
    }
    
    func configure(with model: TableEntry) {
        positionLabel.text = "\(model.position ?? 0)"
        teamIcon.kf.setImage(with: URL(string: model.team?.crest ?? ""))
        
        teamLabel.text = model.team?.name ?? ""
        numberOfGamePlayedLabel.text = "\(model.playedGames ?? 0)"
        goalDifferenceLabel.text = "\(model.goalDifference ?? 0)"
        gamePointsLabel.text = "\(model.points ?? 0)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
