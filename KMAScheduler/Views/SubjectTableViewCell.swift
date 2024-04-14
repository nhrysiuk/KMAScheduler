//
//  SubjectTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "SubjectCell"
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "ProbaPro-Medium", size: 23)
        
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "ProbaPro-Medium", size: 17)
        
        return label
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Configuration
    func configure(with lesson: Lesson) {
        nameLabel.text = lesson.name
        timeLabel.text = lesson.lessonTime
    }

    private func setupUI() {
        backgroundColor = UIColor.backgroundBlue
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.searchBarLightBlue
        selectedBackgroundView = selectedView
        
        accessoryType = .disclosureIndicator
    }
    
    private func setLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
