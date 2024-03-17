//
//  NormativeTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

protocol NormativeProtocol {
    func fetchData()
}

class NormativeTableViewController: UITableViewController, NormativeProtocol {

    var normatives: [Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }

    func fetchData() {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        normatives = allSubjects.filter { $0.type == "normative" && $0.specialty == mySpecialty.name }
    }
    

    func setup() {
        self.tableView.backgroundColor = UIColor.backgroundBlue
        
        self.navigationItem.backBarButtonItem?.title = "Налаштування"
        
        self.navigationController?.navigationBar.tintColor = .darkBlue
        self.navigationItem.title = "Нормативні дисципліни"
        
        tableView.register(NormativeGroupTableViewCell.self, forCellReuseIdentifier: "NormativeGroupCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return normatives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormativeGroupCell", for: indexPath) as! NormativeGroupTableViewCell
        
        cell.delegate = self
        cell.configure(with: normatives[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
