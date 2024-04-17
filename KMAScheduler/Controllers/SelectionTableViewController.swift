//
//  ProfessionalTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 17.03.2024.
//

import UIKit

class SelectionTableViewController: UITableViewController, NormativeProtocolDelegate {
    
    // MARK: - Properties
    var selectives = [Subject]()
    
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchData()
    }
    
    
    // MARK: - Set Up
    func setup() {
        tableView.backgroundColor = .backgroundBlue
        tableView.allowsSelection = false
        
        navigationController?.navigationBar.tintColor = .darkBlue
        navigationItem.title = "Вибіркові дисципліни"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        
        tableView.register(NormativeGroupTableViewCell.self, forCellReuseIdentifier: "NormativeGroupCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Налаштування"
    }
    
    
    func fetchData() {
        selectives = DBProcessor.shared.fetchSelectives()
        tableView.reloadData()
    }
    
    // MARK: - Methods
    @objc func addButtonTapped() {
        let vc = SelectionViewController()
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
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
        return Const.tableCellHeight
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectives[indexPath.row].isRegistered = false
            selectives[indexPath.row].group = 0
            
            fetchData()
        }
    }
}
