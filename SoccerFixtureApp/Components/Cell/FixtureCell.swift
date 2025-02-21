//
//  FixtureCell.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 21/02/2025.
//

import UIKit

class FixtureCell: UITableViewCell {
    
    static let reseuseIdentifier = "FixtureCell"
    
    var mainStackView: UIStackView = UIStackView()
    var timeStackView: UIStackView = UIStackView()
    var teamsStackView: UIStackView = UIStackView()
    var scoreStackView: UIStackView = UIStackView()
    
    var timeHeader: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var timeLabel: UILabel = UILabel.headerTextLabel(fontSize: 18)
    var matchDayLabel: UILabel = UILabel.infoLabel(text: "", fontSize: 10)
    
    var homeTeam: UILabel = UILabel.headerTextLabel(fontSize: 16)
    var awayTeam: UILabel = UILabel.headerTextLabel(fontSize: 16)
    
    var durationLabel: UILabel = UILabel.infoLabel(text: "", fontSize: 10)
    
    var homeTeamScore: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var awayTeamScore: UILabel = UILabel.headerTextLabel(fontSize: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainStackView)
        [
            timeStackView,
            teamsStackView,
            durationLabel,
            scoreStackView
        ]
            .forEach { mainStackView.addArrangedSubview($0) }
        
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
        
        backgroundColor = .systemBackground
        
        setupUI()
    }
    
    func setupUI() {
        layoutMainStackView()
        layoutTimeStackView()
        layoutTeamsStackView()
        layoutTeamScoreStackView()
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutTimeStackView() {
        timeStackView.axis = .vertical
        timeStackView.spacing = 8
        timeStackView.distribution = .equalSpacing
        timeStackView.anchor(width: 80)
        
        [
            timeHeader,
            timeLabel,
            matchDayLabel
        ].forEach {
            timeStackView.addArrangedSubview($0)
        }
        
        timeHeader.text = "TIMED"
        matchDayLabel.textColor = .systemGray
    }
    
    func layoutMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.spacing = 2
    }
    
    func layoutTeamsStackView() {
        teamsStackView.axis = .vertical
        teamsStackView.spacing = 10
        teamsStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55).isActive = true
        
        [homeTeam, awayTeam].forEach({teamsStackView.addArrangedSubview($0)})
    }
    
    func layoutTeamScoreStackView() {
        [homeTeamScore, awayTeamScore].forEach({scoreStackView.addArrangedSubview($0)})
        scoreStackView.axis =  .vertical
        scoreStackView.spacing = 16
        scoreStackView.distribution = .fillEqually
    }
    
    func configure(with model: Matches) {
        matchDayLabel.text = "MD: \(model.matchday ?? 0)"
        timeLabel.text = model.utcDate.getTime()
        
        homeTeam.text = model.homeTeam.name ?? ""
        awayTeam.text = model.awayTeam.name ?? ""
        
        durationLabel.text = model.status
        
        awayTeamScore.text = "\(model.score.fullTime.awayTeam ?? 0)"
        homeTeamScore.text = "\(model.score.fullTime.homeTeam ?? 0)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
