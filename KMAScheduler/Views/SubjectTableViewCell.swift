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
    
    private var placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "ProbaPro-Medium", size: 17)
        
        return label
    }()

    private var circleView: UIImageView = {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10)
        let circleSymbol = UIImage(systemName: "circle.fill", withConfiguration: symbolConfiguration)!
           
        let imageView = UIImageView(image: circleSymbol)
        imageView.tintColor = .cobalt
        return imageView
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
        placeLabel.text = lesson.auditorium
        
        if let notes = lesson.notes {
            if !notes.isEmpty {
                circleView.isHidden = false
            } else {
                circleView.isHidden = true
            }
        } else {
            circleView.isHidden = true
        }
    }

    private func setupUI() {
        backgroundColor = .backgroundBlue
        
        let selectedView = UIView()
        selectedView.backgroundColor = .searchBarLightBlue
        selectedBackgroundView = selectedView
    
        accessoryType = .disclosureIndicator
    }
    
    private func setLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(placeLabel)
        contentView.addSubview(circleView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.safeOffset),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.safeOffset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.safeOffset),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            placeLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 40),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
