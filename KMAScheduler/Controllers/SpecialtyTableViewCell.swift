//
//  NormativeTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SpecialtyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SpecialtyCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: Const.mediumFontName, size: Const.mediumFont)
        label.text = "Спеціальність"
        
        return label
    }()
    
    // MARK: - View controller lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set up
    private func setupUI() {
        backgroundColor = UIColor.backgroundBlue
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.searchBarLightBlue
        selectedBackgroundView = selectedView
        
        accessoryType = .disclosureIndicator
        contentView.addSubview(myLabel)
    }
    
    private func setLayout() {
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.safeOffset),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.safeOffset),
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
