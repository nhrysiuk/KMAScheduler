//
//  NormativeGroupTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class NormativeGroupTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private var delegate: NormativeProtocolDelegate?
    
    static let identifier = "Specialty"
    private var subject: Subject?
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = Const.mediumFont
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.text = ""
        
        return label
    }()
    
    private let button = UIButton()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Up
    private func setupUI() {
        self.backgroundColor = .backgroundBlue
        
        let selectedView = UIView()
        selectedView.backgroundColor = .searchBarLightBlue
        selectedBackgroundView = selectedView
    }
    
    private func setLayout() {
        self.contentView.addSubview(label)
        self.contentView.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15)
        ])
    }
    
    private func setupButton() {
        let actionClosure = { [self] (action: UIAction) in
            fetchAndChangeGroup(with: action.title)
        }
        
        var menuChildren: [UIMenuElement] = []
        menuChildren.append(UIAction(title: "Не обрано", handler: actionClosure))
        
        guard let subject else { return }
        for group in 1...subject.numberOfGroups {
            let action = UIAction(title: String(group), handler: actionClosure)
            if group == subject.group {
                action.state = .on
            }
            
            menuChildren.append(action)
        }
        
        if subject.group != 0 {
            button.setTitle(String(subject.group), for: .normal)
            print(String(subject.group))
        } else {
            button.setTitle("Не обрано", for: .normal)
        }
        
        button.menu = UIMenu(options: .displayInline, children: menuChildren)
        
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        
        button.tintColor = .darkBlue
        button.backgroundColor = .darkBlue
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkBlue.cgColor
    }
    
    private func changeLabelName() {
        guard let subject else { return }
        label.text = subject.name
    }
    
    //MARK: - Configuration
    func configure(with subject: Subject, and delegate: NormativeProtocolDelegate) {
        self.subject = subject
        self.delegate = delegate
        
        setupButton()
        changeLabelName()
    }
    
    private func fetchAndChangeGroup(with number: String) {
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        let currSubject = allSubjects.first { $0.id == subject?.id }
        
        if let num = Int64(number) {
            currSubject?.group = num
        } else {
            currSubject?.group = 0
        }
        CoreDataProcessor.shared.saveContext()
        
        delegate?.fetchData()
    }
}
