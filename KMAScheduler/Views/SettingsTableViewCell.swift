//
//  NormativeTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SettingsCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = Const.mediumFont
        
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
    func configure(with name: String) {
        myLabel.text = name
    }
    
    private func setupUI() {
        backgroundColor = .backgroundBlue
        
        let selectedView = UIView()
        selectedView.backgroundColor = .searchBarLightBlue
        selectedBackgroundView = selectedView
        
        accessoryType = .disclosureIndicator
    }
    
    private func setLayout() {
        contentView.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.safeOffset),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.safeOffset),
            myLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
