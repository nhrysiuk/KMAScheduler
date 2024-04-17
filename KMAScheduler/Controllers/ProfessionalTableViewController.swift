//
//  SelectiveTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class ProfessionalTableViewController: UITableViewController, NormativeProtocolDelegate {
    
    //MARK: - Properties
    private var selectives = [Subject]()
    
    //MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Налаштування"
    }
    
    //MARK: - Set Up
    private func setup() {
        tableView.backgroundColor = .backgroundBlue
        tableView.allowsSelection = false
        
        navigationController?.navigationBar.tintColor = .darkBlue
        navigationItem.title = "Професійні дисципліни"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        
        tableView.register(NormativeGroupTableViewCell.self, forCellReuseIdentifier: "NormativeGroupCell")
        
    }
    
    //MARK: - Methods
    @objc private func addButtonTapped() {
        let vc = ProfessionalViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
        
    func fetchData() {
        selectives = DBProcessor.shared.fetchProfessionals()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormativeGroupCell", for: indexPath) as! NormativeGroupTableViewCell
        
        cell.configure(with: selectives[indexPath.row], and: self)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectives[indexPath.row].isRegistered = false
            selectives[indexPath.row].group = 0
            
            fetchData()
        }
    }
}
