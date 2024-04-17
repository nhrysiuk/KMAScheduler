//
//  SpecialtyViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SpecialtyViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - Properties
    var delegate: CurrentSpecialtyDelegate?
    
    private var filteredSpecialties: [String] = []
    private var isFiltering = false
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundBlue
        
        return tableView
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .backgroundBlue
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = .searchBarLightBlue
        }
        
        return searchBar
    }()
    
    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setLayout()
    }
    
    //MARK: - Set up
    private func setup() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
        view.backgroundColor = .backgroundBlue
        navigationItem.backBarButtonItem?.tintColor = .darkBlue
        filteredSpecialties = Const.specialties
        
            
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
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
    }
}

// MARK: - Table view data source
extension SpecialtyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSpecialties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
    
        let text = if filteredSpecialties.isEmpty {
            Const.specialties[indexPath.row]
        } else {
            filteredSpecialties[indexPath.row]
        }
    
        cell.configure(with: text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let specialty = if filteredSpecialties.isEmpty {
            Const.specialties[indexPath.row]
        } else {
            filteredSpecialties[indexPath.row]
        }
        
        CoreDataProcessor.shared.deleteExistingSpecialties()
        
        let newSpecialty = MySpecialty(context: CoreDataProcessor.shared.context)
        newSpecialty.name = specialty
        CoreDataProcessor.shared.saveContext()
        
        delegate?.update()
        
        dismiss(animated: true)
    }
}

    //MARK: - UISearchBarDelegate
extension SpecialtyViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredSpecialties = Const.specialties
            tableView.reloadData()
            
            return
        }
        
        filteredSpecialties = Const.specialties.filter {$0.contains(searchText)}
        tableView.reloadData()
    }
}
