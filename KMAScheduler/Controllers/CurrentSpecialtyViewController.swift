//
//  CurrentSpecialtyViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

protocol CurrentSpecialtyDelegate {
    func update()
}

class CurrentSpecialtyViewController: UIViewController, CurrentSpecialtyDelegate {
    
    //MARK: - Properties
    
    private var specialtyData: MySpecialty?
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.mediumFontName, size: Const.largeFont)
        label.textColor = .darkBlue
        label.text = "Ваша спеціальність: "
        
        return label
    }()
    
    private let specialtyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.boldFontName, size: Const.largeFont)
        label.textColor = .darkBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: Const.mediumFontName, size: Const.bigFont)
        button.setTitleColor(.cobalt, for: .normal)
        button.setTitle("Змінити", for: .normal)
        
        return button
    }()
    
    private let courseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Const.mediumFontName, size: Const.bigFont)
        label.textColor = .darkBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Курс:"
        
        return label
    }()
    
    private let courseButton = UIButton()
    
    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCourseButton()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
    }
    
    //MARK: - Set up
    private func setLayout() {
        view.backgroundColor = .backgroundBlue
        
        specialtyLabel.text = "Не обрано"
        button.setTitle("Обрати", for: .normal)
        
        view.addSubview(label)
        view.addSubview(specialtyLabel)
        view.addSubview(button)
        view.addSubview(courseLabel)
        view.addSubview(courseButton)
        
        navigationController?.navigationBar.tintColor = .darkBlue
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            
            specialtyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            specialtyLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            specialtyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            specialtyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 20),
            
            courseLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30),
            courseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            courseButton.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: 10),
            courseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupCourseButton() {
        let actionClosure = { [self] (action: UIAction) in
            guard let number = Int(action.title) else { return }
            updateGroup(with: number)
        }
    
        var menuChildren: [UIMenuElement] = []
        menuChildren.append(UIAction(title: "Не обрано", handler: actionClosure))
        
        for course in 1...4 {
            let action = UIAction(title: String(course), handler: actionClosure)
            if let year = specialtyData?.year {
                if year == course {
                    action.state = .on
                }
            }
    
            menuChildren.append(action)
        }
     
        if let year = specialtyData?.year {
            courseButton.setTitle(String(year), for: .normal)
        }
        
        courseButton.menu = UIMenu(options: .displayInline, children: menuChildren)
        
        courseButton.showsMenuAsPrimaryAction = true
        courseButton.changesSelectionAsPrimaryAction = true
        
        courseButton.tintColor = .darkBlue
        courseButton.backgroundColor = .darkBlue
        courseButton.layer.cornerRadius = 0
        courseButton.layer.borderWidth = 1
        courseButton.layer.borderColor = UIColor.darkBlue.cgColor
    }
    
    //MARK: - Update
    func update() {
        let data = CoreDataProcessor.shared.fetch(MySpecialty.self)
        
        guard let specialty = data.first else { return }
        specialtyData = specialty
        updateUI(with: specialty)
        updateData(with: specialty)
        setupCourseButton()
        

    }
    
    private func updateUI(with specialty: MySpecialty) {
        DispatchQueue.main.async { [self] in
            guard let name = specialty.name else { return }
            specialtyLabel.text = name
            button.setTitle("Змінити", for: .normal)
            
        }
    }
    
    private func updateData(with specialty: MySpecialty) {
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        
        allSubjects.forEach { subject in
            if subject.isRegistered && subject.type == "normative" {
                subject.isRegistered = false
                subject.group = 0
            }
        }
        
        allSubjects.forEach { subject in
            if subject.type == "normative" && subject.specialty == specialty.name {
                subject.isRegistered = true
            }
        }
    }
    
    func updateGroup(with number: Int) {
        let data = CoreDataProcessor.shared.fetch(MySpecialty.self)
        
        guard let specialty = data.first else { return }
        specialty.year = Int64(number)
        CoreDataProcessor.shared.saveContext()
    }
    
    @objc private func didTapButton() {
        let vc = SpecialtyViewController()
        vc.delegate = self
        
        navigationController?.present(vc, animated: true)
    }
}
