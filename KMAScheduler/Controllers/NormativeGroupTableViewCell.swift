//
//  NormativeGroupTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class NormativeGroupTableViewCell: UITableViewCell {
    
    var delegate: NormativeProtocol?
    
    static let identifier = "Specialty"
    var subject: Subject?
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ProbaPro-Medium", size: 24)
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    let button = UIButton(primaryAction: nil)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
    
        self.backgroundColor = UIColor.backgroundBlue
        
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
    
    func configure(with subject: Subject) {
        self.subject = subject
        setupButton()
        changeLabelName()
    }
    
    func setupButton() {
        
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
        button.backgroundColor = .lightBlue
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkBlue.cgColor
    }
    
    func changeLabelName() {
        guard let subject else { return }
        label.text = subject.name
    }
    
    func fetchAndChangeGroup(with number: String) {
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
