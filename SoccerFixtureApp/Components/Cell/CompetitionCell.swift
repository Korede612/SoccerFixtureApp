//
//  CompetitionCell.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 21/02/2025.
//

import UIKit

class CompetitionCell: UITableViewCell {
    
    static let reseuseIdentifier = "CompetitionCell"
    
    var competitionNameLabel: UILabel = UILabel()
    var forwardImage: UIImageView = UIImageView()
    
    var competitionName: String = "" {
        didSet {
            competitionNameLabel.text = competitionName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(competitionNameLabel)
        addSubview(forwardImage)
        competitionNameLabel.text = "Testing"
        
        backgroundColor = .systemBackground
        
        setupUI()
    }
    
    func setupUI() {
        layoutComponentNameLabel()
        layoutForwardImage()
    }
    
    func layoutComponentNameLabel() {
        competitionNameLabel.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor, paddingTop: 10, paddingLeft: 16, paddingBottom: 10, paddingRight: 26)
    }
    
    func layoutForwardImage() {
        forwardImage.anchor(trailing: trailingAnchor, paddingRight: 10, width: 30, height: 30)
        forwardImage.centerAnchor(axis: .vertical, on: self)
        forwardImage.image = UIImage(named: "chevron-right")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
