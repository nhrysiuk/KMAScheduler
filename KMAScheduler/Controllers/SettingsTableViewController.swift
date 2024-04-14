//
//  SettingsTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 11.01.2024.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FileReader.fetchSubjectsFromFile()
        setup()
    }

    // MARK: - Set up
    private func setup() {
        tableView.backgroundColor = UIColor.backgroundBlue
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.title = "Налаштування"
        
        tableView.register(SpecialtyTableViewCell.self, forCellReuseIdentifier: "SpecialtyCell")
        tableView.register(NormativeTableViewCell.self, forCellReuseIdentifier: "Normative")
        tableView.register(ProfessionalTableViewCell.self, forCellReuseIdentifier: "Professional")
        tableView.register(SelectiveTableViewCell.self, forCellReuseIdentifier: "Selective")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "SpecialtyCell", for: indexPath) as! SpecialtyTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Normative", for: indexPath) as! NormativeTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "Professional", for: indexPath) as! ProfessionalTableViewCell
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "Selective", for: indexPath) as! SelectiveTableViewCell
        default:
            fatalError()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Const.tableCellHeight
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
