//
//  SelectionViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 17.03.2024.
//

import UIKit

class SelectionViewController: UIViewController, UITableViewDelegate {
    
    var delegate: NormativeProtocol?
    
    var filteredSubjects = [Subject]()
    var professionalSubjects = [Subject]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.backgroundBlue
        
        return tableView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor.backgroundBlue
        
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupUI()
    }
    
    func fetchData() {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        professionalSubjects = allSubjects.filter { (!$0.isRegistered && $0.specialty == mySpecialty.name && $0.type == "selective") ||
            (!$0.isRegistered && $0.specialty != mySpecialty.name) }
    }
    
    func setupUI() {
        tableView.register(ProfessionalTableViewCell.self, forCellReuseIdentifier: "Professional")
        
        view.backgroundColor = UIColor.backgroundBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem?.tintColor = .darkBlue

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

extension SelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filteredSubjects.count)
        return filteredSubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Professional", for: indexPath) as! ProfessionalTableViewCell
        if filteredSubjects.isEmpty {
            cell.label.text = professionalSubjects[indexPath.row].name
        } else {
            cell.label.text = filteredSubjects[indexPath.row].name
        }
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.searchBarLightBlue
        cell.selectedBackgroundView = selectedView
        
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

extension SelectionViewController: UISearchBarDelegate {
    
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
