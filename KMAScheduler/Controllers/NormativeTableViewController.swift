//
//  NormativeTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

protocol NormativeProtocolDelegate {
    func fetchData()
}

class NormativeTableViewController: UITableViewController, NormativeProtocolDelegate {

    // MARK: - Properties
    private var normatives: [Subject] = []
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        fetchData()
    }

    func fetchData() {
        normatives = DBProcessor.shared.fetchNormatives()
    }
    
    // MARK: - Set Up
    private func setUp() {
        tableView.backgroundColor = .backgroundBlue
        tableView.allowsSelection = false
        
        navigationController?.navigationBar.tintColor = .darkBlue
        navigationItem.title = "Нормативні дисципліни"
        
        tableView.register(NormativeGroupTableViewCell.self, forCellReuseIdentifier: "NormativeGroupCell")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return normatives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormativeGroupCell", for: indexPath) as! NormativeGroupTableViewCell
        
        cell.configure(with: normatives[indexPath.row], and: self)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Const.tableCellHeight
    }
}
