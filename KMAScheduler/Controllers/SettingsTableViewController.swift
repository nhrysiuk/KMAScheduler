//
//  SettingsTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSubjectsIfNeeded()
        setup()
    }

    func setup() {
        self.tableView.backgroundColor = UIColor.backgroundBlue
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: nil, action: nil)

        self.navigationItem.title = "Налаштування"
        tableView.register(SpecialtyTableViewCell.self, forCellReuseIdentifier: "Specialty")
        tableView.register(NormativeTableViewCell.self, forCellReuseIdentifier: "Normative")
        tableView.register(ProfessionalTableViewCell.self, forCellReuseIdentifier: "Professional")
        tableView.register(SelectiveTableViewCell.self, forCellReuseIdentifier: "Selective")
    }
    
    func fetchSubjectsIfNeeded() {
        let data = CoreDataProcessor.shared.fetch(Subject.self)
        guard data.isEmpty else { return }
        FileReader.fetchSubjectsFromFile()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "Specialty", for: indexPath) as! SpecialtyTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Normative", for: indexPath) as! NormativeTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "Professional", for: indexPath) as! ProfessionalTableViewCell
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "Selective", for: indexPath) as! SelectiveTableViewCell
        default:
            print(indexPath.row)
            fatalError()
        }
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.searchBarLightBlue
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let vc = CurrentSpecialtyViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = NormativeTableViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = ProfessionalTableViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = SelectionTableViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
