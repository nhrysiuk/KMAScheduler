//
//  CurrentSpecialtyViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

protocol CurrentSpecialtyDelegate {
    func updateUI()
}

class CurrentSpecialtyViewController: UIViewController, CurrentSpecialtyDelegate {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ProbaPro-Medium", size: 35)
        label.textColor = .darkBlue
        label.text = "Ваша спеціальність: "
        
        return label
    }()
    
    private let specialtyLabel: UILabel = {
        //TODO: бд
        let label = UILabel()
        label.font = UIFont(name: "ProbaPro-Bold", size: 35)
        label.textColor = .darkBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "ProbaPro-Medium", size: 25)
        button.setTitleColor(.brightBlue, for: .normal)
        button.setTitle("Змінити", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.backgroundBlue

        view.addSubview(label)
        view.addSubview(specialtyLabel)
        view.addSubview(button)
       
        self.navigationController?.navigationBar.tintColor = .darkBlue
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            
            specialtyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            specialtyLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            specialtyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            specialtyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: specialtyLabel.bottomAnchor, constant: 20.0),
        ])

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    func updateUI() {
        let nameData = CoreDataProcessor.shared.fetch(MySpecialty.self)
        
        if nameData.isEmpty {
            specialtyLabel.text = "Не обрано"
            button.setTitle("Обрати", for: .normal)
        } else {
            DispatchQueue.main.async {
                guard let name = nameData.first!.name else { return }
                self.specialtyLabel.text = name
            }
        }
    }
    
    @objc func didTapButton() {
        let vc = SpecialtyViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
}
