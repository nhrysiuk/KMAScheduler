//
//  ProfessionalViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 17.03.2024.
//

import UIKit

class ProfessionalViewController: UIViewController, UITableViewDelegate {

    // MARK: - Properties
    var delegate: NormativeProtocolDelegate?
    
    private var filteredSubjects = [Subject]()
    private var professionalSubjects = [Subject]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundBlue
        
        return tableView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .backgroundBlue
        
        return searchBar
    }()
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        professionalSubjects = DBProcessor.shared.fetchAllProfessionals()
        setupUI()
        setLayout()
    }
    
    //MARK: - Set Up
    private func setupUI() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
        view.backgroundColor = .backgroundBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem?.tintColor = .darkBlue
    }
    
    private func setLayout() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        filteredSubjects = professionalSubjects
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

// MARK: - Table view data source
extension ProfessionalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredSubjects.count)
        return filteredSubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
        let text = if filteredSubjects.isEmpty {
            professionalSubjects[indexPath.row].name
        } else {
            filteredSubjects[indexPath.row].name
        }
        
        guard let text else { return cell }
        
        cell.configure(with: text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subjectToAdd = if filteredSubjects.isEmpty {
            professionalSubjects[indexPath.row]
        } else {
            filteredSubjects[indexPath.row]
        }
        
        subjectToAdd.isRegistered = true
        
        CoreDataProcessor.shared.saveContext()
        
        delegate?.fetchData()
        
        self.dismiss(animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension ProfessionalViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredSubjects = professionalSubjects
            self.tableView.reloadData()
            return
        }
        
        self.filteredSubjects = professionalSubjects.filter {$0.name!.contains(searchText)}
        self.tableView.reloadData()
    }
}
