//
//  SelectiveTableViewController.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class SelectiveTableViewController: UITableViewController {

    var selectives = ["Теорія ймовірностей", "Вебпрограмування", "Логічне програмування"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        self.tableView.backgroundColor = UIColor.backgroundBlue
        
        self.navigationController?.navigationBar.tintColor = .darkBlue
        self.navigationItem.title = "Вибіркові дисципліни"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))

        tableView.register(NormativeGroupTableViewCell.self, forCellReuseIdentifier: "NormativeGroupCell")
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Set custom text for the back button in the next view controller
            self.navigationController?.navigationBar.topItem?.title = "Налаштування"
        }
    
    @objc func addButtonTapped() {
        self.navigationController?.present(SpecialtyViewController(), animated: true)
  // TODO: 
        //items.append(newItem)

       // let indexPath = IndexPath(row: items.count - 1, section: 0)
        //tableView.insertRows(at: [indexPath], with: .automatic)
        }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NormativeGroupCell", for: indexPath) as! NormativeGroupTableViewCell
        
        cell.label.text = selectives[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
