//
//  SearchSelectiveViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class SearchSelectiveViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    var specialties = ["121.Інженерія програмного забезпечення", "122.Компʼютерні науки", "035.Філологія", "081.Право", "037.Філософія"]
    
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
        
        filteredSpecialties = specialties
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

// MARK: - Table view data source

extension SearchSelectiveViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSpecialties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: змінити шрифт; створити кастом селл
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = filteredSpecialties[indexPath.row]
        cell.contentConfiguration = content
        
        cell.backgroundColor = UIColor.backgroundBlue
        cell.tintColor = .darkBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: бд.......................зберігання зовнішнє спеціальности
        self.dismiss(animated: true)
    }
}

extension SearchSelectiveViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredSpecialties = self.specialties
            self.tableView.reloadData()
            return
        }
        
        self.filteredSpecialties = self.specialties.filter {$0.contains(searchText)}
        self.tableView.reloadData()
    }
}

