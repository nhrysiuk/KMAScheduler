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
        tableView.backgroundColor = .backgroundBlue
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.title = "Налаштування"
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
        
        let name = switch indexPath.row {
        case 0:
            "Спеціальність"
        case 1:
            "Нормативні дисципліни"
        case 2:
            "Професійні дисципліни"
        case 3:
            "Дисципліни вільного вибору"
        default:
            fatalError()
        }
        
        cell.configure(with: name)
        
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
