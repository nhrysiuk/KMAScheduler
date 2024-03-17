//
//  SelectiveTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class ProfessionalTableViewController: UITableViewController, NormativeProtocol {
    
    var selectives = [Subject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchData()
    }
    
    func setup() {
        self.tableView.backgroundColor = UIColor.backgroundBlue
        
        self.navigationController?.navigationBar.tintColor = .darkBlue
        self.navigationItem.title = "Професійні дисципліни"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        
        tableView.register(NormativeGroupTableViewCell.self, forCellReuseIdentifier: "NormativeGroupCell")
    }
    
    func fetchData() {
        guard let mySpecialty = CoreDataProcessor.shared.fetch(MySpecialty.self).first else { return }
        let allSubjects = CoreDataProcessor.shared.fetch(Subject.self)
        selectives = allSubjects.filter { subject in
            return subject.isRegistered &&
                   subject.specialty == mySpecialty.name &&
                   subject.type == "prof"
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Налаштування"
    }
    
    @objc func addButtonTapped() {
        let vc = ProfessionalViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormativeGroupCell", for: indexPath) as! NormativeGroupTableViewCell
        
        cell.delegate = self
        cell.configure(with: selectives[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}