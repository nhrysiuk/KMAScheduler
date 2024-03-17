//
//  NormativesViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SpecialtyViewController: UIViewController, UITableViewDelegate {
    
    var delegate: CurrentSpecialtyDelegate?
    
    var filteredSpecialties: [String] = []
    
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
        setupUI()
    }
    
    func setupUI() {
        
        tableView.register(SpecialtyChoiceTableViewCell.self, forCellReuseIdentifier: "SpecialtyChoice")
        
        view.backgroundColor = UIColor.backgroundBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem?.tintColor = .darkBlue

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
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
        
        filteredSpecialties = Const.specialties
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

// MARK: - Table view data source

extension SpecialtyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSpecialties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialtyChoice", for: indexPath) as! SpecialtyChoiceTableViewCell
        if filteredSpecialties.isEmpty {
            cell.label.text = Const.specialties[indexPath.row]
        } else {
            cell.label.text = filteredSpecialties[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let specialty = Const.specialties[indexPath.row]
        
        CoreDataProcessor.shared.deleteExistingSpecialties()
        
        let newSpecialty = MySpecialty(context: CoreDataProcessor.shared.context)
        newSpecialty.name = specialty
        CoreDataProcessor.shared.saveContext()
        
        delegate?.updateUI()
        
        self.dismiss(animated: true)
    }
}

extension SpecialtyViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredSpecialties = Const.specialties
            self.tableView.reloadData()
            return
        }
        
        self.filteredSpecialties = Const.specialties.filter {$0.contains(searchText)}
        self.tableView.reloadData()
    }
}
