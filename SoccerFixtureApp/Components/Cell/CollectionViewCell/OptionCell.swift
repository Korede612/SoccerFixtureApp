//
//  OptionCell.swift
//  SoccerFixtureApp
//
//  Created by Oko-Osi Korede on 22/02/2025.
//

import UIKit

class OptionCell: UICollectionViewCell {
    
    static let identifier: String = "OptionCell"
    
    var titleLabel: UILabel = UILabel.headerTextLabel(fontSize: 14)
    var optionData: OptionData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    func configureViews() {
        contentView.addSubview(titleLabel)
        titleLabel.anchor(
            trailing: contentView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            leading: contentView.leadingAnchor,
            paddingBottom: 20
        )
        titleLabel.textAlignment = .center
    }
    
    func configure(with optionData: OptionData) {
        self.optionData = optionData
        titleLabel.text = optionData.title
        if optionData.isSelected {
            titleLabel.textColor = .label
        } else {
            titleLabel.textColor = .gray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
