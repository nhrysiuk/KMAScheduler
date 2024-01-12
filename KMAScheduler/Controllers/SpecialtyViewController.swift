//
//  NormativesViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SpecialtyViewController: UIViewController {
    
    var specialities = ["121.Інженерія програмного забезпечення", "122.Компʼютерні наукма", "035.Філологія", "081.Право", "037.Філософія"]
    
    var filteredSpecialaities: [String] = []
    
    
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
        self.view.backgroundColor = UIColor.backgroundBlue
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.backBarButtonItem?.tintColor = .darkBlue
        
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}

extension SpecialtyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredSpecialaities = self.specialities
            self.tableView.reloadData()
            return
        }
        
        self.filteredSpecialaities = self.specialities.filter {$0.contains(searchText)}
        self.tableView.reloadData()
    }
}
